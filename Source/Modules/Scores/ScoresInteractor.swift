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

// MARK: - ScoresInteractor Class
final class ScoresInteractor: Interactor {
    lazy var endpointsApiService = EndpointsApiService()
}

// MARK: - ScoresInteractor API
extension ScoresInteractor: ScoresInteractorApi {

    func fetchScoreData() -> Single<GsmrsDto> {
        return endpointsApiService.getScores()
            .map(GsmrsDto.self, using: GsmrsDto.xmlDecoder)
    }

}
