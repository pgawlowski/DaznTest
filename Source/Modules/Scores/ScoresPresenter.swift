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

    private var scores: PublishSubject<ScoresViewModel?> = PublishSubject()

    func fetchData() -> Driver<Void> {
        return interactor.fetchScoreData()
            .do(onSuccess: { [weak self] response in
                self?.scores.onNext(response)
                self?.view.endRefreshing()
            }, onError: { [weak self] error in
                self?.view.showError(error)
            }).map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
    }

}

// MARK: - ScoresPresenter API
extension ScoresPresenter: ScoresPresenterApi {
    struct Input {
        let refreshTrigger: Driver<Void>
    }
    struct Output {
        let cancelable: Cancelable
        let scores: Driver<ScoresViewModel?>
    }

    func transform(_ input: Input) -> Output {
        let refreshInput = input.refreshTrigger.flatMapLatest { [unowned self] _ -> Driver<Void> in
            self.fetchData()
        }

        let cancelable = Disposables.create([
            refreshInput.drive(),
        ])

        let scoresOutput = scores.asDriver(onErrorJustReturn: nil)

        return Output(cancelable: cancelable,
                      scores: scoresOutput)
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
