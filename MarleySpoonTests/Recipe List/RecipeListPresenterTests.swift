//
//  RecipeListPresenterTests.swift
//  MarleySpoonTests
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import XCTest
@testable import MarleySpoon
/*
    func presentRecipeList(from response: RecipeItem.Response)
    func presentError()
 */
class MockrecipeListViewController: UIViewController, RecipeListDisplayProtocol {
    var wasErrorDisplayed = false
    var recipes: [RecipeItem.Recipe]?
    func displayRecipes(recipes: [RecipeItem.Recipe]) {
        self.recipes = recipes
    }
    func displayError() {
       wasErrorDisplayed = true
    }
    func setupRouter(with router: GlobarlRoutingProtocol?) {}
}
class RecipeListPresenterTests: XCTestCase {
    var mockViewController = MockrecipeListViewController()
    var presenter = RecipeListPresenter()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockViewController.recipes = nil
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testPresentRecipeList() {
        presenter.setViewContoller(with: mockViewController)
        presenter.presentRecipeList(from: MockData.recipeListResponseWithAssets)
        XCTAssertFalse(mockViewController.wasErrorDisplayed)
        XCTAssertEqual(mockViewController.recipes?.count, MockData.recipeListResponseWithAssets.items.count,
                       "The number of recipes should be equal to the recipes in the API response")
        XCTAssertNotNil(mockViewController.recipes?.first?.photo)
        XCTAssertEqual(mockViewController.recipes?.first?.tags?.count, 0,
                       "This mock response only has photo, no tags or chef")
        XCTAssertNil(mockViewController.recipes?.first?.chef)
        XCTAssertNil(mockViewController.recipes?.first?.photo?.file, "The file should be nil because despite having the photo, theres no id matching in the assets list. There should be one")
    }
}
