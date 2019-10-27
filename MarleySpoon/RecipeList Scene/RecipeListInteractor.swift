//
//  RecipeListInteractor.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation

protocol RecipeListBusinessLogic: GlobalInteractorProtocol {
    func getAllRecipes()
}
class RecipeListInteractor: RecipeListBusinessLogic {
    private var worker: RecipeListAPIHandler
    private var presenter: RecipeListPresentingLogic?
    init(with worker: RecipeListAPIHandler) {
        self.worker = worker
    }
    func setPresenter(with presenter: GlobalPresenterProtocol?) {
        self.presenter = presenter as? RecipeListPresentingLogic
    }
    func getAllRecipes() {
        worker.loadAllRecipes { (result) in
            switch result {
            case .success(let response):
                self.presenter?.presentRecipeList(from: response)
            case .failure(let error):
                //Not doing anything error specific for now
                print("\(error)")
                self.presenter?.presentError()
            }
        }
    }
}
