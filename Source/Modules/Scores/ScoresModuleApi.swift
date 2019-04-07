//
//  ScoresModuleApi.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import Viperit

// MARK: - ScoresRouter API
protocol ScoresRouterApi: RouterProtocol {
}

// MARK: - ScoresView API
protocol ScoresViewApi: DaznUserInterfaceProtocol {
}

// MARK: - ScoresPresenter API
protocol ScoresPresenterApi: PresenterProtocol {
    func transform(_ input: ScoresPresenter.Input) -> ScoresPresenter.Output
}

// MARK: - ScoresInteractor API
protocol ScoresInteractorApi: InteractorProtocol {
    func fetchScoreData() -> Single<ScoresViewModel?>
}
