//
//  NewsPresenter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwifterSwift
import Viperit

// MARK: - NewsPresenter Class
final class NewsPresenter: Presenter {

    private var news: PublishSubject<[RssItemDto]> = PublishSubject()

    func fetchData() -> Driver<Void> {
        return interactor.fetchRssNews()
            .doWithLoader()
            .do(onSuccess: { [weak self] response in
                self?.news.onNext(response)
                self?.view.endRefreshing()
            }, onError: { [weak self] error in
                self?.view.showError(error)
            }).map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
    }

    func selectItem(_ indexPath: Observable<IndexPath>) -> Driver<Void> {
        return Observable.zip(indexPath, news.asObservable())
            .do(onNext: { [weak self] indexPath, news in
                guard let item = news[safe: indexPath.item],
                    let url = item.link else { return }
                self?.router.navigateToNewsDetails(url)
            }).map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
    }

}

// MARK: - NewsPresenter API
extension NewsPresenter: NewsPresenterApi {
    struct Input {
        let refreshTrigger: Driver<Void>
        let itemSelected: Observable<IndexPath>
    }
    struct Output {
        let cancelable: Cancelable
        let news: Driver<[RssItemDto]>
    }

    func transform(_ input: Input) -> Output {
        let didSelectItem = selectItem(input.itemSelected)
        let refreshInput = input.refreshTrigger.flatMapLatest { [unowned self] _ -> Driver<Void> in
            self.fetchData()
        }

        let cancelable = Disposables.create([
            refreshInput.drive(),
            didSelectItem.drive()
        ])

        let newsOutput = news.asDriver(onErrorJustReturn: [])

        return Output(cancelable: cancelable,
                      news: newsOutput)
    }
}

// MARK: - News Viper Components
private extension NewsPresenter {
    var view: NewsViewApi {
        // swiftlint:disable force_cast
        return _view as! NewsViewApi
        // swiftlint:enable force_cast
    }
    var interactor: NewsInteractorApi {
        // swiftlint:disable force_cast
        return _interactor as! NewsInteractorApi
        // swiftlint:enable force_cast
    }
    var router: NewsRouterApi {
        // swiftlint:disable force_cast
        return _router as! NewsRouterApi
        // swiftlint:enable force_cast
    }
}
