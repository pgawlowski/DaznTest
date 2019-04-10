//
//  StandingsRouter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import Viperit

// MARK: - StandingsRouter class
final class StandingsRouter: Router {
}

// MARK: - StandingsRouter API
extension StandingsRouter: StandingsRouterApi {
}

// MARK: - Standings Viper Components
private extension StandingsRouter {
    var presenter: StandingsPresenterApi {
        // swiftlint:disable force_cast
        return _presenter as! StandingsPresenterApi
        // swiftlint:enable force_cast
    }
}
