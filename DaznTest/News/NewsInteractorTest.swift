//
//  NewsInteractorTest.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 10/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//


import XCTest
import RxTest
import RxSwift
import RxCocoa
import Moya
@testable import Dazn

// MARK: - NewsInteractorTest Class
final class NewsInteractorTest: XCTestCase {
    
    var subscription: Disposable!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    var interactor: NewsInteractor!
    
    var defaultExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        interactor = NewsInteractor()

        // TODO: set interactor services with stubbed responses
        interactor.endpointsApiService = EndpointsApiService(stubClosure: MoyaProvider.immediatelyStub, responseCode: testCase.responseCode, fileName: testCase.file)
        disposeBag = DisposeBag()
        defaultExpectation = XCTestExpectation(description: "defaultExpectation")

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private var testCase: (responseCode: Int, file: String) {
        switch self.name {
        case formatted(name: "test_fetchDataSuccess"):
            return (200, "newsFeedFull")
        case formatted(name: ""):
            return (400, "")
        default:
            return (-1, "")
        }
    }

    func test_fetchDataSuccess() {
        interactor.fetchRssNews()
            .subscribe(onSuccess: { response in
                self.defaultExpectation.fulfill()
            }) { error in
                XCTFail()
            }.disposed(by: disposeBag)
    }
}
