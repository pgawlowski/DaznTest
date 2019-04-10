//
//  NewsDetailsModuleApi.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import Viperit

//MARK: - NewsDetailsRouter API
protocol NewsDetailsRouterApi: RouterProtocol {
}

//MARK: - NewsDetailsView API
protocol NewsDetailsViewApi: DaznUserInterfaceProtocol {
    func setupWebView(_ url: URL)
}

//MARK: - NewsDetailsPresenter API
protocol NewsDetailsPresenterApi: PresenterProtocol {
}

//MARK: - NewsDetailsInteractor API
protocol NewsDetailsInteractorApi: InteractorProtocol {
}
