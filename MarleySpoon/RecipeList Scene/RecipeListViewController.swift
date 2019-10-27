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
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "recipeCell")
            setupRefreshControl()
        }
    }
    private var refreshControl = UIRefreshControl()
    private var interactor: RecipeListBusinessLogic?
    private var router: RecipeListRoutingProtocol?
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
                     refreshButton: UIButton,
                     presenter: RecipeListPresentingLogic?,
                     and interactor: RecipeListBusinessLogic?) {
        self.init(with: presenter, and: interactor)
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.refreshButton = refreshButton
        self.activityIndicator = activityIndicator
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Recipes"
        collectionView.isHidden = true
        interactor?.getAllRecipes()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    @objc private func refresh() {
        refreshButton.isHidden = true
        activityIndicator.startAnimating()
        interactor?.getAllRecipes()
    }
    // MARK: - Protocol conformance
    func setupRouter(with router: GlobarlRoutingProtocol?) {
        self.router = router as? RecipeListRoutingProtocol
    }
    func displayRecipes(recipes: [RecipeItem.Recipe]) {
        self.recipes = recipes
        refreshControl.endRefreshing()
        refreshButton.isHidden = true
        collectionView.isHidden = false
        activityIndicator.stopAnimating()
        collectionView.reloadData()
    }
    func displayError() {
        //Same for all errors for now
        activityIndicator.stopAnimating()
        collectionView.isHidden = true
        refreshButton.isHidden = false
    }
    // MARK: - Actions
    @IBAction func refreshTapped(_ sender: Any) {
        refresh()
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.goToRecipeDetail(with: recipes[indexPath.row])
    }
}
