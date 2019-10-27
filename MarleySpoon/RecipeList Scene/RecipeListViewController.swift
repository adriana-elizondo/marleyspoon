//
//  RecipeListViewController.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeListDisplayProtocol: GlobalDisplayProtocol {
    func displayRecipes(recipes: [RecipeItem.Recipe])
    func displayError()
}
class RecipeListViewController: UIViewController, RecipeListDisplayProtocol {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "recipeCell")
        }
    }
    private var interactor: RecipeListBusinessLogic?
    private var recipes = [RecipeItem.Recipe]()
    convenience init(with presenter: RecipeListPresentingLogic?,
                     and interactor: RecipeListBusinessLogic?) {
        self.init(name: nil)
        presenter?.setViewContoller(with: self)
        interactor?.setPresenter(with: presenter)
        self.interactor = interactor
    }
    // MARK: - Testing initializer
    convenience init(with collectionView: UICollectionView,
                     activityIndicator: UIActivityIndicatorView,
                     presenter: RecipeListPresentingLogic?,
                     and interactor: RecipeListBusinessLogic?) {
        self.init(with: presenter, and: interactor)
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.activityIndicator = activityIndicator
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Recipes"
        collectionView.isHidden = true
        interactor?.getAllRecipes()
    }
    // MARK: - Protocol conformance
    func setupRouter(with router: GlobarlRoutingProtocol?) {}
    func displayRecipes(recipes: [RecipeItem.Recipe]) {
        self.recipes = recipes
        collectionView.isHidden = false
        activityIndicator.stopAnimating()
        collectionView.reloadData()
    }
    func displayError() {
        //Same for all errors for now
    }
}

extension RecipeListViewController: UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath)
            as? RecipeCollectionViewCell {
            cell.setup(with: recipes[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let itemSize = (view.frame.size.width / 2) - padding
        return CGSize(width: itemSize, height: itemSize * 1.2)
    }
}
