//
//  RecipeListInteractorTests.swift
//  MarleySpoonTests
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import XCTest
import NetworkLayer
@testable import MarleySpoon
/*
    func getAllRecipes()
 */
class MockRecipeListWorker: RecipeListAPIHandler {
    private var shouldReturnError = false
    init(with shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    func loadAllRecipes(with completion: @escaping RecipeListCompletionBlock) {
        if shouldReturnError {
            completion(.failure(NetworkResponseError.badRequest(error: nil)))
        } else {
            completion(.success(MockData.recipeListResponseWithAssets))
        }
    }
}
class MockRecipeListPresenter: RecipeListPresentingLogic {
    var recipeListResponse: RecipeItem.Response?
    var wasErrorPresented = false
    func presentRecipeList(from response: RecipeItem.Response) {
        recipeListResponse = response
    }
    func presentError() {
        wasErrorPresented = true
    }
    func setViewContoller(with controller: UIViewController?) {}
}
class RecipeListInteractorTests: XCTestCase {
    var interactor: RecipeListBusinessLogic?
    var worker: RecipeListAPIHandler?
    var presenter: MockRecipeListPresenter?
    override func setUp() {
        //
        presenter = MockRecipeListPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGetAllRecipesWithSuccess() {
        worker = MockRecipeListWorker(with: false)
        interactor = RecipeListInteractor(with: worker!)
        interactor?.setPresenter(with: presenter)
        interactor?.getAllRecipes()
        XCTAssertFalse(presenter!.wasErrorPresented)
        XCTAssertNotNil(presenter?.recipeListResponse)
    }
    func testGetAllRecipesWithError() {
        worker = MockRecipeListWorker(with: true)
        interactor = RecipeListInteractor(with: worker!)
        interactor?.setPresenter(with: presenter)
        interactor?.getAllRecipes()
        XCTAssertTrue(presenter!.wasErrorPresented)
    }
}
