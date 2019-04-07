//
//  ScoresInteractor.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Viperit
import SwifterSwift

// MARK: - ScoresInteractor Class
final class ScoresInteractor: Interactor {
    lazy var endpointsApiService = EndpointsApiService()
}

// MARK: - ScoresInteractor API
extension ScoresInteractor: ScoresInteractorApi {

    func fetchGsmrs() -> Single<GsmrsDto> {
        return endpointsApiService.getScores()
            .map(GsmrsDto.self, using: GsmrsDto.xmlDecoder)
    }

    func fetchScoreData() -> Single<ScoresViewModel?> {
        return fetchGsmrs()
            .map({ gsmrs -> ScoresViewModel in
                let dateString = gsmrs.method?.parameter?.first { $0.name == "date" }?.value ?? ""

                let groups = gsmrs.competition?.season?.round?.group
                let matches = groups?.compactMap({ $0.match }).flatMap{ $0 } ?? []

                return ScoresViewModel(dateString, matches)
            })
    }

}
