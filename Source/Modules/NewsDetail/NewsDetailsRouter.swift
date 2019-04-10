//
//  NewsDetailsRouter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import Viperit

// MARK: - NewsDetailsRouter class
final class NewsDetailsRouter: Router {
}

// MARK: - NewsDetailsRouter API
extension NewsDetailsRouter: NewsDetailsRouterApi {
}

// MARK: - NewsDetails Viper Components
private extension NewsDetailsRouter {
    var presenter: NewsDetailsPresenterApi {
        // swiftlint:disable force_cast
        return _presenter as! NewsDetailsPresenterApi
        // swiftlint:enable force_cast
    }
}
