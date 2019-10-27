//
//  RecipeListPresenter.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeListPresentingLogic: GlobalPresenterProtocol {
    func presentRecipeList(from response: RecipeItem.Response)
    func presentError()
}

class RecipeListPresenter: RecipeListPresentingLogic {
    private weak var viewcontroller: RecipeListDisplayProtocol?
    func setViewContoller(with controller: UIViewController?) {
        self.viewcontroller = controller as? RecipeListDisplayProtocol
    }
    // MARK: - Success
    func presentRecipeList(from response: RecipeItem.Response) {
        viewcontroller?.displayRecipes(recipes: parseResponse(response: response))
    }
    private func parseResponse(response: RecipeItem.Response) -> [RecipeItem.Recipe] {
        var recipes = [RecipeItem.Recipe]()
        for recipe in response.items {
            var updatedRecipe = recipe.fields
            if let chefId = recipe.fields.chef?.sys?.elementId {
                if let chef = response.includes.entry.first(where: { $0.sys.elementId == chefId}) {
                    updatedRecipe.chef = RecipeItem.Chef(name: chef.fields.name)
                }
            }
            if let photoId = recipe.fields.photo?.sys?.elementId {
                if let photo = response.includes.asset.first(where: { $0.sys.elementId == photoId}) {
                    let url = "https:\(photo.fields.file?.url ?? "")"
                    updatedRecipe.photo = RecipeItem.Asset(sys: photo.sys,
                                                                  file: RecipeItem.Asset.AssetFile(url: url))
                }
            }
            var tags = [RecipeItem.Tag]()
            for tag in recipe.fields.tags ?? [RecipeItem.Tag]() {
                if let includesTag = response.includes.entry.first(where: { $0.sys.elementId == tag.sys?.elementId}) {
                    tags.append(RecipeItem.Tag(sys: includesTag.sys, name: includesTag.fields.name))
                }
            }
            updatedRecipe.tags = tags
            recipes.append(updatedRecipe)
        }
        return recipes
    }
    // MARK: - Error
    func presentError() {
        viewcontroller?.displayError()
    }
}
