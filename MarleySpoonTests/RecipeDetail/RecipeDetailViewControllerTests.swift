//
//  RecipeDetailViewControllerTests.swift
//  MarleySpoonTests
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import XCTest
@testable import MarleySpoon
class MockLoadingView: UIView {}
class MockTitleLabel: UILabel {}
class MockRecipeDetailViewController: RecipeDetailViewController {
    var recipe: RecipeItem.Recipe?
    override func displayRecipeDetails(with recipe: RecipeItem.Recipe) {
        self.recipe = recipe
    }
}
class RecipeDetailViewControllerTests: XCTestCase {
    var mockLoadingView = MockLoadingView()
    var mockTitleLabel = MockTitleLabel()
    var viewController: MockRecipeDetailViewController?
    override func setUp() {
        viewController = MockRecipeDetailViewController(with: MockData.singleRecipe,
                                                    loadingView: mockLoadingView,
                                                    recipeTitle: mockTitleLabel)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testRecipeIsLoadedCorrectlyOnDetailViewController() {
        viewController?.viewDidLoad()
        XCTAssertEqual(viewController?.recipe?.title, MockData.singleRecipe.title)
    }
}
