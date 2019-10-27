//
//  MockData.swift
//  MarleySpoonTests
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
@testable import MarleySpoon

struct MockData {
    static let imageUrl = "//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg"
    static let assetResponse = AssetResponse(sys: Sys(elementId: "asset-ID-that-doesnt-match"),
                                             fields: RecipeItem.Asset(sys: Sys(elementId: "test-ID"),
                                                                      file: RecipeItem.Asset.AssetFile(url: MockData.imageUrl)))
    static let includes = RecipeItem.Includes(entry: [EntryResponse(
                                                        sys: Sys(elementId: "test-ID"),
                                                        fields: EntryResponse.EntryFields(name: "test enry"))],
                                              asset: [MockData.assetResponse])
    static let recipeListResponseWithoutAssets = RecipeItem.Response(items: [ContentfulRecipe(sys:
        Sys(elementId: "test-ID"),
                                                                                 fields: RecipeItem.Recipe(
                                                                                    title: "test title",
                                                                                    calories: 1500,
                                                                                    description: "test description",
                                                                                    tags: nil,
                                                                                    photo: nil,
                                                                                    chef: nil))],
                                                        includes: MockData.includes)
    static let recipeListResponseWithAssets = RecipeItem.Response(items: [ContentfulRecipe(sys:
        Sys(elementId: "test-ID"),
                             fields: RecipeItem.Recipe(
                                title: "test title",
                                calories: 1500,
                                description: "test description",
                                tags: nil,
                                photo: RecipeItem.Asset(sys: Sys(elementId: "asset-ID"), file: nil),
                                chef: nil))],
    includes: MockData.includes)
    static let parsedRecipes = [RecipeItem.Recipe(title: "Test recipe",
                                                  calories: 100,
                                                  description: "test description",
                                                  tags: nil,
                                                  photo: nil,
                                                  chef: nil)]
}
