//
//  ViewController.swift
//  Recipe
//
//  Created by Roshan sah on 22/11/20.
//

import UIKit

class RecipeViewController: UIViewController {
    
    private struct Constant {
        static let cellID = "RecipeTableViewCellID"
        static let nib = "RecipeTableViewCell"
    }
    
    private var recipeViewMode = RecipeViewModel()
    
    @IBOutlet weak var cartTitle: UIBarButtonItem!
    
    var order: RecipeViewModel.OrderBy = .descending
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    @IBOutlet weak var cart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchRecipe()
        self.registerCell()
    }
    
    func registerCell() {
        self.recipeTableView.register(UINib(nibName: Constant.nib, bundle: .main), forCellReuseIdentifier: Constant.cellID)
    }
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        self.recipeViewMode.sortByPrice(inOrder: order)
        self.recipeTableView.reloadData()
        if self.order == .ascending {
            self.order = .descending
            self.setSortTitle(title: "<")
        } else {
            self.order = .ascending
            self.setSortTitle(title: ">")
        }
    }
    
    func setSortTitle(title: String) {
        self.cartTitle.title = " Sort \(title)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "carts" {
            let destinationViewController = segue.destination as? CardViewController
            destinationViewController?.cart = self.recipeViewMode.cart
        }
        
    }
    
}

extension RecipeViewController {
    
    private func fetchRecipe() {
        self.recipeViewMode.fetchRecipes { isSuccess in
            switch isSuccess {
            case true:
                self.recipeTableView.reloadData()
            case false:
                self.recipeTableView.reloadData()
            }
        }
    }
}

extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipeViewMode.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellID, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = self.recipeViewMode.recipes[indexPath.row]
        cell.configureCell(withRecipe: recipe)
        return cell
    }
}

extension RecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToCart = UIContextualAction(style: .normal, title: "Add to Cart") { (action, view, handler) in
            // Get the recipe
            let recipe = self.recipeViewMode.recipes[indexPath.row]
            // Add to cart
            self.recipeViewMode.add(toCart: recipe) { isSuccess in
                if isSuccess {
                    // Reload table view
                    self.cart.setTitle("\(self.recipeViewMode.cart.count)", for: .normal)
                    self.recipeTableView.reloadData()
                }
                
            }
            
        }
        addToCart.backgroundColor = .systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [addToCart])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            let recipe = self.recipeViewMode.recipes[indexPath.row]
            self.recipeViewMode.remove(formCart: recipe)
            self.recipeTableView.reloadData()
        }
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
