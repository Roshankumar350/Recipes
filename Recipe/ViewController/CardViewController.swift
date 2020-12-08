//
//  CardViewController.swift
//  Recipe
//
//  Created by Roshan sah on 08/12/20.
//

import UIKit

class CardViewController: UIViewController {
    
    private struct Constant {
        static let cellID = "RecipeTableViewCellID"
        static let nib = "RecipeTableViewCell"
    }
    
    var cart = [Recipes]()
    
    @IBOutlet weak private var cartTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
    }
    
    private func registerCell() {
        self.cartTableview.register(UINib(nibName: Constant.nib, bundle: .main), forCellReuseIdentifier: Constant.cellID)
    }
}

extension CardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellID, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = self.cart[indexPath.row]
        cell.configureCell(withRecipe: recipe)
        return cell
    }
}

