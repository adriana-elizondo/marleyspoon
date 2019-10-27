//
//  RecipeDetailViewController.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
protocol RecipeDetailDisplayProtocol: GlobalDisplayProtocol {
    func displayRecipeDetails(with recipe: RecipeItem.Recipe)
}
class RecipeDetailViewController: UIViewController, RecipeDetailDisplayProtocol {
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitle: UILabel!
    @IBOutlet private weak var recipeDescription: UILabel!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var acitvityIndicator: UIActivityIndicatorView!
    private var recipe: RecipeItem.Recipe?
    // Testing initializer
    convenience init(with recipe: RecipeItem.Recipe?,
                     loadingView: UIView,
                     recipeTitle: UILabel) {
        self.init(with: recipe)
        self.loadingView = loadingView
        self.recipeTitle = recipeTitle
    }
    convenience init(with recipe: RecipeItem.Recipe?) {
        self.init(name: nil)
        self.recipe = recipe
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        title = "More Details"
        guard recipe != nil else {
            displayError()
            return
        }
        displayRecipeDetails(with: recipe!)
    }
    func setupRouter(with router: GlobarlRoutingProtocol?) {}
    // MARK: - Protocol functions
    func displayRecipeDetails(with recipe: RecipeItem.Recipe) {
        //Load ui
        acitvityIndicator.stopAnimating()
        loadingView.isHidden = true
        if let url = URL(string: recipe.photo?.file?.url ?? "") {
            recipeImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        recipeTitle.text = recipe.title
        recipeDescription.text = recipe.description
        caloriesLabel.text = "Calories: \(recipe.calories)"
        tagsLabel.text = recipe.tagsString
        authorLabel.text = recipe.chefName.isEmpty ? "" : "by: \(recipe.chefName)"
    }
    func displayError() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Oh oh! something went wrong, want to go back to the recipe list?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alertController, animated: true, completion: nil)
    }
}
