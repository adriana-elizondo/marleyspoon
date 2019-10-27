//
//  APIExtensions.swift
//  MarleySpoon
//
//  Created by Adriana Elizondo on 2019/10/27.
//  Copyright © 2019 Adriana. All rights reserved.
//

import Foundation
import NetworkLayer

private let SPACEID = "kk2bw5ojx476"

extension EndpointType {
    var baseUrl: URL {
        return URL(string: "https://cdn.contentful.com")!
    }
    var path: String {
        return "/spaces/\(SPACEID)/environments/master/entries"
    }
}
