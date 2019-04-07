//
//  ScoresPresenter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Viperit

// MARK: - ScoresPresenter Class
final class ScoresPresenter: Presenter {
}

// MARK: - ScoresPresenter API
extension ScoresPresenter: ScoresPresenterApi {

    func fetchData() -> Driver<Void> {
        return interactor.fetchScoreData()
            .do(onSuccess: { response in
                print(response)
            }, onError: { [weak self] error in
                self?.view.showError(error)
            }).map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
    }

}

// MARK: - Scores Viper Components
private extension ScoresPresenter {
    var view: ScoresViewApi {
        // swiftlint:disable force_cast
        return _view as! ScoresViewApi
        // swiftlint:enable force_cast
    }
    var interactor: ScoresInteractorApi {
        // swiftlint:disable force_cast
        return _interactor as! ScoresInteractorApi
        // swiftlint:enable force_cast
    }
    var router: ScoresRouterApi {
        // swiftlint:disable force_cast
        return _router as! ScoresRouterApi
        // swiftlint:enable force_cast
    }
}
