//
//  RecipeTableViewCell.swift
//  Recipe
//
//  Created by Roshan sah on 22/11/20.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipePrice: UILabel!
    @IBOutlet weak var recipeContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.recipeContentView.setCardView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(withRecipe recipe: Recipes) {
        self.recipeContentView.addShadow()

//        ImageCache.publicCache.load(url: NSURL(string: recipe.image)!, item: recipe) { (fetchedItem, image) in
//            if let img = image {
//                self.recipeImage.image = img
//            }
//        }
        UIImage.getImage(forURLString: recipe.image ?? "") { recipeImageURLString, recipeImage in
            if let image = recipeImage {
                if recipe.image == recipeImageURLString {
                    self.recipeImage.image = image
                } else {
                    self.recipeImage.image = UIImage(named: "recipe")
                }
            } else {
                self.recipeImage.image = UIImage(named: "recipe")
            }
        }
        
        self.recipeName.text = recipe.name
        self.recipePrice.text = recipe.price
    }
    
}
