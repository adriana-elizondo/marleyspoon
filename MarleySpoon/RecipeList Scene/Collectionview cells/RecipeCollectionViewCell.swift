//
//  RecipeTableViewCell.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var recipeTitle: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    func setup(with recipe: RecipeItem.Recipe) {
        if let url = URL(string: recipe.photo?.file?.url ?? "") {
            recipeImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        recipeTitle.text = recipe.title
        tagsLabel.text = recipe.tagsString
    }
}
