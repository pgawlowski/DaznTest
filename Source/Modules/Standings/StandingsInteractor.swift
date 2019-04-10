//
//  StandingsInteractor.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Viperit

// MARK: - StandingsInteractor Class
final class StandingsInteractor: Interactor {
    lazy var endpointsApiService = EndpointsApiService()
}

// MARK: - StandingsInteractor API
extension StandingsInteractor: StandingsInteractorApi {

    func fetchRankingData() -> Single<[RankingDto]> {
        return fetchStandingsData()
            .map {
                var rankings = $0.competition?.season?.round?.resultstable?.ranking ?? []
                rankings.sort(by: { $0.rank ?? 0 <= $1.rank ?? 0 })
                return rankings
            }
    }

    func fetchStandingsData() -> Single<GsmrsDto> {
        return endpointsApiService.getStandings()
            .map(GsmrsDto.self, using: GsmrsDto.xmlDecoder)
    }

}
