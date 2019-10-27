//
//  Global.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import UIKit
protocol GlobalDisplayProtocol where Self: UIViewController {
    func setupRouter(with router: GlobarlRoutingProtocol?)
}
protocol GlobalPresenterProtocol {
    func setViewContoller(with controller: UIViewController?)
}
protocol GlobalInteractorProtocol {
    func setPresenter(with presenter: GlobalPresenterProtocol?)
}
protocol GlobarlRoutingProtocol {}
