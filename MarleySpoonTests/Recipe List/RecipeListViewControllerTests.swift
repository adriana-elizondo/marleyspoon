//
//  RecipeListViewControllerTests.swift
//  MarleySpoonTests
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import XCTest
@testable import MarleySpoon
/*
    func displayRecipes(recipes: [RecipeItem.Recipe])
    func displayError()
 */
class MockCollectionView: UICollectionView {}
class MockActivityIndicatorView: UIActivityIndicatorView {}

class RecipeListViewControllerTests: XCTestCase {
    var viewController: RecipeListDisplayProtocol?
    var mockCollectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var mockActivityIndicatorView = MockActivityIndicatorView(style: .medium)
    override func setUp() {
        viewController = RecipeListViewController(with: mockCollectionView,
                                                  activityIndicator: mockActivityIndicatorView,
                                                  refreshButton: UIButton(type: .close),
                                                  presenter: RecipeListPresenter(),
                                                  and: RecipeListInteractor(with: MockRecipeListWorker()))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testDisplayRecipes() {
        viewController?.displayRecipes(recipes: MockData.parsedRecipes)
        XCTAssertEqual(mockCollectionView.numberOfItems(inSection: 0), MockData.parsedRecipes.count,
                       "The recipes should be displayed in the collectionView")
        XCTAssertFalse(mockActivityIndicatorView.isAnimating)
    }
}
