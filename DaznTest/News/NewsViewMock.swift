//
//  NewsViewMock.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 10/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import Viperit
@testable import Dazn

//MARK: NewsViewMock Class
class NewsViewMock: DaznUserInterface, NewsViewApi  {
    
    var errors: [Error] = []
    var endRefreshingCount = 0

    func reset() {
        errors = []
        endRefreshingCount = 0
    }

    override func showError(_ error: Error) {
        errors.append(error)
    }
    
    override func endRefreshing() {
        endRefreshingCount += 1
    }
}
