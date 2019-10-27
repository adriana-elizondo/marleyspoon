//
//  RecipeListRouter.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeListRoutingProtocol: GlobarlRoutingProtocol {
    func goToRecipeDetail(with recipe: RecipeItem.Recipe)
}
class RecipeListRouter: RecipeListRoutingProtocol {
    private weak var navigationController: UINavigationController?
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    func goToRecipeDetail(with recipe: RecipeItem.Recipe) {
        let recipeDetailViewController = RecipeDetailViewController(with: recipe)
        navigationController?.present(recipeDetailViewController, animated: true, completion: nil)
    }
}
