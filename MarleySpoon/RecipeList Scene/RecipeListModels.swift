//
//  RecipeListModels.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation

protocol ContentfulResponse {
    associatedtype Element: Codable
    var fields: Element { get set }
}
typealias ContentfulCodableResponse = ContentfulResponse & Codable

struct Sys: Codable {
    var elementId: String
    private enum CodingKeys: String, CodingKey {
        case elementId = "id"
    }
}
struct ContentfulRecipe: ContentfulCodableResponse {
    var sys: Sys
    var fields: RecipeItem.Recipe
}
struct EntryResponse: ContentfulCodableResponse {
    var sys: Sys
    var fields: EntryFields
    struct EntryFields: Codable {
        var name: String
    }
}
struct AssetResponse: ContentfulCodableResponse {
    var sys: Sys
    var fields: RecipeItem.Asset
}

struct RecipeItem: Codable {
    struct Response: Codable {
        var items: [ContentfulRecipe]
        var includes: Includes
    }
    struct Includes: Codable {
        var entry: [EntryResponse]
        var asset: [AssetResponse]
        private enum CodingKeys: String, CodingKey {
            case entry = "Entry", asset = "Asset"
        }
    }
    struct Recipe: Codable {
        var title: String
        var calories: Int
        var description: String
        var tags: [Tag]?
        var photo: Asset?
        var chef: Chef?
    }
    struct Tag: Codable {
        var sys: Sys?
        var name: String?
    }
    struct Asset: Codable {
        var sys: Sys?
        var file: AssetFile?
        struct AssetFile: Codable {
            var url: String
        }
    }
    struct Chef: Codable {
        var sys: Sys?
        var name: String?
    }
}
