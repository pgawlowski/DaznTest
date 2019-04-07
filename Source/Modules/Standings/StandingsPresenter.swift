//
//  StandingsPresenter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Viperit

// MARK: - StandingsPresenter Class
final class StandingsPresenter: Presenter {
}

// MARK: - StandingsPresenter API
extension StandingsPresenter: StandingsPresenterApi {

    func fetchData() -> Driver<Void> {
        return interactor.fetchStandingsData()
            .do(onSuccess: { response in
                print(response)
            }, onError: { [weak self] error in
                self?.view.showError(error)
            }).map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
    }

}

// MARK: - Standings Viper Components
private extension StandingsPresenter {
    var view: StandingsViewApi {
        // swiftlint:disable force_cast
        return _view as! StandingsViewApi
        // swiftlint:enable force_cast
    }
    var interactor: StandingsInteractorApi {
        // swiftlint:disable force_cast
        return _interactor as! StandingsInteractorApi
        // swiftlint:enable force_cast
    }
    var router: StandingsRouterApi {
        // swiftlint:disable force_cast
        return _router as! StandingsRouterApi
        // swiftlint:enable force_cast
    }
}
