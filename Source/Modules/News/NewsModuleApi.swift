//
//  NewsModuleApi.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Moya
import RxCocoa
import RxSwift
import Viperit

// MARK: - NewsRouter API
protocol NewsRouterApi: RouterProtocol {
    func navigateToNewsDetails(_ url: URL)
}

// MARK: - NewsView API
protocol NewsViewApi: DaznUserInterfaceProtocol {
}

// MARK: - NewsPresenter API
protocol NewsPresenterApi: PresenterProtocol {
    func transform(_ input: NewsPresenter.Input) -> NewsPresenter.Output
}

// MARK: - NewsInteractor API
protocol NewsInteractorApi: InteractorProtocol {
    func fetchRssNews() -> Single<[RssItemDto]>
}
