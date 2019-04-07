//
//  NewsInteractor.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxSwift
import Viperit
import XMLParsing

// MARK: - NewsInteractor Class
final class NewsInteractor: Interactor {
    lazy var endpointsApiService = EndpointsApiService()
}

// MARK: - NewsInteractor API
extension NewsInteractor: NewsInteractorApi {

    func fetchRssNews() -> Single<[RssItemDto]> {
        return endpointsApiService.getNews()
            .map(RssDto.self, using: RssDto.xmlDecoder)
            .map{ $0.channel?.item ?? [] }
    }
}
