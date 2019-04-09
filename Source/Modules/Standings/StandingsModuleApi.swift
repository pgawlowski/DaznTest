//
//  StandingsModuleApi.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import Viperit

// MARK: - StandingsRouter API
protocol StandingsRouterApi: RouterProtocol {
}

// MARK: - StandingsView API
protocol StandingsViewApi: DaznUserInterfaceProtocol {
}

// MARK: - StandingsPresenter API
protocol StandingsPresenterApi: PresenterProtocol {
    func transform(_ input: StandingsPresenter.Input) -> StandingsPresenter.Output
}

// MARK: - StandingsInteractor API
protocol StandingsInteractorApi: InteractorProtocol {
    func fetchRankingData() -> Single<[RankingDto]>
    func fetchStandingsData() -> Single<GsmrsDto>
}
