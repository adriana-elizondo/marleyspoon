//
//  RecipeListService.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import NetworkLayer

struct RecipeListParameters: Codable {}
class RecipeListService: EndpointType {
    var recipeListParameters: [String: Any] {
        return ["content_type": "recipe",
                "include": 1]
    }
    var httpMethod: HttpMethod { return .get }
    var headers: HttpHeaders? {
        return ["Authorization": "Bearer 7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"]
    }
    var task: HttpTask<RecipeListParameters> {
        return HttpTask.requestWithHeaders(headers: headers, queryParameters: recipeListParameters)
    }
    typealias ParameterType = RecipeListParameters
    func getRecipeList(completion: @escaping (RecipeItem.Response?, NetworkResponseError?) -> Void) {
        let router = Router<RecipeListService, RecipeItem.Response>()
        router.request(with: self) { (response, _, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}
