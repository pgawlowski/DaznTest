//
//  NewsInteractorMock.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 10/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxSwift
import Viperit
@testable import Dazn

// MARK: - NewsInteractorTestCase Class
enum NewsInteractorTestCase: Int {
    case ok
    case error

    mutating func next(){
        self = NewsInteractorTestCase(rawValue: rawValue + 1) ?? .ok
    }
    
    func response() -> Single<[RssItemDto]> {
        switch self {
        case .ok:
            return Single.just(try! RssItemDto.loadJSONArrayFromFile(name: "newsFeed"))
        case .error:
            return Single.error(NSError(domain: NSURLErrorDomain, code: 400))
        }
    }
}

class NewsInteractorMock: Interactor, NewsInteractorApi {
    var testCase: NewsInteractorTestCase = .ok

    func fetchRssNews() -> Single<[RssItemDto]> {
        return testCase.response()
    }
}

