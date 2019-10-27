//
//  RecipeTableViewCell.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var recipeTitle: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    func setup(with recipe: RecipeItem.Recipe) {
        if let url = URL(string: recipe.photo?.file?.url ?? "") {
            recipeImage.setImage(from: url)
        }
        recipeTitle.text = recipe.title
        tagsLabel.text = ""
        guard let tags = recipe.tags else { return }
        var tagsString = ""
        for (index, tag) in tags.enumerated() {
            tagsString += tag.name ?? ""
            if index < tags.count - 1 { tagsString += ", "}
        }
        tagsLabel.text = tagsString
    }
}
