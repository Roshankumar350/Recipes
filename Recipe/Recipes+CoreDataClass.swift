//
//  Recipes+CoreDataClass.swift
//  Recipe
//
//  Created by Roshan sah on 23/11/20.
//
//

import Foundation
import CoreData

@objc(Recipes)
public class Recipes: NSManagedObject {
    
    convenience init(withRecipe recipe: Recipe, AndManageObjectContext context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = Int16(recipe.id)
        self.category = recipe.category.rawValue
        self.image = recipe.image
        self.label = recipe.label
        self.price = recipe.price
        self.welcomeDescription = recipe.welcomeDescription
    }

}
