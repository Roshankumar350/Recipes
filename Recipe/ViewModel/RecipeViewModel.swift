//
//  RecipeViewModel.swift
//  Recipe
//
//  Created by Roshan sah on 22/11/20.
//

import Foundation
import UIKit
import CoreData
import Combine

final class RecipeViewModel {
    
    // MARK: - Properties
    
    lazy var session: URLSession = {
        let config: URLSessionConfiguration = .default
        config.waitsForConnectivity = true
        return URLSession(configuration: config)
    }()
    
    private var anyCancllable: AnyCancellable?
    
    private(set) var recipes = [Recipes]()
    
    private(set) var cart = [Recipes]()
    
    init() {}
    
    func fetchRecipes(completion isSucessed: @escaping (Bool) -> Void) {
        self.anyCancllable = session.callingEndPoint(forRequest: URLRequest(forHttpMethod: .GET, forAssociatedURL: .recipe))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DispatchQueue.main.async {
                        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
                        do {
                            self.recipes = try managedObjectContext.fetch(fetchRequest)
                        } catch let error as NSError {
                          print("Could not save. \(error), \(error.userInfo)")
                        }
                        isSucessed(true)
                    }
                case .failure(let error):
                    isSucessed(false)
                    print(error.localizedDescription)
                }
            }, receiveValue: { data in
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        let recipes = try decoder.decode([Recipe].self, from: data)
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                        
                        recipes.forEach { recipe in
                            let _ = Recipes(withRecipe: recipe, AndManageObjectContext: context)
                        }
                        do {
                            try context.save()
                        } catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                    } catch {
                        debugPrint(error)
                        self.recipes = []
                    }
                }
            })
    }
    
}

extension RecipeViewModel {
    enum OrderBy {
        case ascending
        case descending
    }
    func sortByPrice(inOrder order: OrderBy) {
        switch order {
        case .ascending:
            self.recipes.sort(by: <)
        case .descending:
            self.recipes.sort(by: >)
        }
    }
}


extension RecipeViewModel {
    func add(toCart recipe: Recipes, completion: (Bool) -> Void) {
        guard let recipeIndex = self.recipes.firstIndex(of: recipe) else {
            completion(false)
            return
        }
        self.recipes.remove(at: recipeIndex)
        self.cart.append(recipe)
        completion(true)
    }
    
    func remove(formCart recipe: Recipes) {
        guard let recipeIndex = self.recipes.firstIndex(of: recipe) else {
            return
        }
        
        self.recipes.insert(recipe, at: recipeIndex)
        
        guard let recipeIndexForCart = self.cart.firstIndex(where: { cartRecipe -> Bool in
            return cartRecipe.id == recipe.id
        }) else {
            return
        }
        
        self.cart.remove(at: recipeIndexForCart)
        
    }
}
