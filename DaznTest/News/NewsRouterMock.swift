//
//  NewsRouterMock.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 10/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import Viperit
@testable import Dazn

// MARK: - NewsRouter class
class NewsRouterMock: Router, NewsRouterApi {
    var didMoveToDetails: Int = 0

    func navigateToNewsDetails(_ url: URL) {
        didMoveToDetails += 1
    }
}
