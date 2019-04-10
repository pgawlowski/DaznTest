//
//  NewsRouter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import Viperit

// MARK: - NewsRouter class
final class NewsRouter: Router {
}

// MARK: - NewsRouter API
extension NewsRouter: NewsRouterApi {

    func navigateToNewsDetails(_ url: URL) {
        let module = AppModules.newsDetails.build()
        module.router.show(from: _view, setupData: url)
    }

}

// MARK: - News Viper Components
private extension NewsRouter {
    var presenter: NewsPresenterApi {
        // swiftlint:disable force_cast
        return _presenter as! NewsPresenterApi
        // swiftlint:enable force_cast
    }
}
