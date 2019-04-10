//
//  EndpointsApiService.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Moya
import RxSwift

class EndpointsApiService: MoyaSugar<ApiEndpoints> {

    func getNews() -> Single<Response> {
        return provider.rx.request(.getLatestsNews)
            .filterSuccessfulStatusCodes()
    }

    func getScores() -> Single<Response> {
        return provider.rx.request(.getScores)
            .filterSuccessfulStatusCodes()
    }

    func getStandings() -> Single<Response> {
        return provider.rx.request(.getStandings)
            .filterSuccessfulStatusCodes()
    }
}
