//
//  RecipeListWorker.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import NetworkLayer

typealias RecipeListCompletionBlock = (Result<RecipeItem.Response, NetworkResponseError>) -> Void

protocol RecipeListAPIHandler {
    func loadAllRecipes(with completion: @escaping RecipeListCompletionBlock)
}

class ReciperListWorker: RecipeListAPIHandler {
    private let recipeListService = RecipeListService()
    func loadAllRecipes(with completion: @escaping RecipeListCompletionBlock) {
        recipeListService.getRecipeList { (response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard response != nil else {
                completion(.failure(.parsingError(error: error)))
                return
            }
            completion(.success(response!))
        }
    }
}
