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

    private var standings: PublishSubject<[RankingDto]> = PublishSubject()

    func fetchData() -> Driver<Void> {
        return interactor.fetchRankingData()
            .do(onSuccess: { [weak self] response in
                self?.standings.onNext(response)
                self?.view.endRefreshing()
            }, onError: { [weak self] error in
                self?.view.endRefreshing()
                self?.view.showError(error)
            }).map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
    }
}

// MARK: - StandingsPresenter API
extension StandingsPresenter: StandingsPresenterApi {
    struct Input {
        let refreshTrigger: Driver<Void>
    }
    struct Output {
        let cancelable: Cancelable
        let standings: Driver<[RankingDto]>
    }

    func transform(_ input: Input) -> Output {
        let refreshInput = input.refreshTrigger.flatMapLatest { [unowned self] _ -> Driver<Void> in
            self.fetchData()
        }

        let cancelable = Disposables.create([
            refreshInput.drive(),
        ])

        let standingsOutput = standings.asDriver(onErrorJustReturn: [])

        return Output(cancelable: cancelable,
                      standings: standingsOutput)
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
