//
//  ScoresRouter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import Viperit

// MARK: - ScoresRouter class
final class ScoresRouter: Router {
}

// MARK: - ScoresRouter API
extension ScoresRouter: ScoresRouterApi {
}

// MARK: - Scores Viper Components
private extension ScoresRouter {
    var presenter: ScoresPresenterApi {
        // swiftlint:disable force_cast
        return _presenter as! ScoresPresenterApi
        // swiftlint:enable force_cast
    }
}
