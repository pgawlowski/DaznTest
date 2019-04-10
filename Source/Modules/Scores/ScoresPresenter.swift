//
//  ScoresPresenter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import RxSwiftExt
import RxCocoa
import RxSwift
import Viperit

// MARK: - ScoresPresenter Class
final class ScoresPresenter: Presenter {

    private var scores: PublishSubject<[ScoreSectionModel]> = PublishSubject()

    func loopFetchData() -> Driver<Void> {
        return Observable<Int>
            .timer(0.0, period: ScoresValues.period, scheduler: MainScheduler.instance)
            .flatMap { [weak self] _ -> Observable<Void> in
                return self?.fetchScores() ?? Observable.just(())
            }.asDriver(onErrorJustReturn: ())
    }

    func fetchScores() -> Observable<Void> {
        return interactor.fetchScoreData()
            .doWithLoader()
            .asObservable()
            .retry(.delayed(maxCount: ScoresValues.repeatMaxCount, time: ScoresValues.repeatTime))
            .do(onNext: { [weak self] response in
                self?.scores.onNext(response)
            }, onError: { [weak self] error in
                self?.view.showError(error)
            }).map { _ in Void() }
    }
}

// MARK: - ScoresPresenter API
extension ScoresPresenter: ScoresPresenterApi {
    struct Input {
        let refreshTrigger: Driver<Void>
    }
    struct Output {
        let cancelable: Cancelable
        let scores: Driver<[ScoreSectionModel]>
    }

    func transform(_ input: Input) -> Output {
        let refreshInput = input.refreshTrigger.flatMapLatest { [unowned self] _ -> Driver<Void> in
            self.loopFetchData()
        }
        let cancelable = Disposables.create([
            refreshInput.drive(),
        ])
        let scoresOutput = scores.asDriver(onErrorJustReturn: [])

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
