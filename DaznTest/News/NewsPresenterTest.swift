//
//  NewsPresenterTest.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 10/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import Dazn

// MARK: - NewsPresenterTest Class
class NewsPresenterTest: XCTestCase {
    
    var subscription: Disposable!
    var disposeBag: DisposeBag!
    var defaultExpectation: XCTestExpectation!
    var scheduler: TestScheduler!
    
    var view: NewsViewMock!
    var interactor: NewsInteractorMock!
    var presenter: NewsPresenter!
    var router: NewsRouterMock!
    
    override func setUp() {
        super.setUp()
        
        disposeBag = DisposeBag()
        defaultExpectation = XCTestExpectation(description: "defaultExpectation")
        scheduler = TestScheduler(initialClock: 0)
        
        view = NewsViewMock()
        interactor = NewsInteractorMock()
        router = NewsRouterMock()
        
        presenter = NewsPresenter()
        presenter._view = view
        presenter._interactor = interactor
        presenter._router = router
    }
    
    override func tearDown() {
        scheduler.scheduleAt(1000, action: {
            self.subscription.dispose()
        })
        super.tearDown()
    }

    func test_refreshTrigger() {
        let trigger = self.scheduler.createHotObservable([
            next(100, ()),
            next(200, ()),
            next(300, ()),
            next(400, ())
            ])
            .do(onNext: { _ in
                self.interactor.testCase.next()
            })

        let observer = scheduler.createObserver([RssItemDto].self)
        let input = createInput(refreshTrigger: trigger.asDriver(onErrorJustReturn: ()))

        let output = presenter.transform(input)
        scheduler.scheduleAt(0, action: {
            output.cancelable.disposed(by: self.disposeBag)
            output.news.asObservable()
                .subscribe(observer)
                .disposed(by: self.disposeBag)
        })
        scheduler.start()
        let results = observer.events.map {
            $0.value.element?.count
        }
        XCTAssertEqual(results, [10, 10])
        XCTAssertEqual(view.errors.count, 2)
    }

    func test_selectItem() {
        let selectTrigger = scheduler.createHotObservable([
            next(100, (IndexPath(row: 0, section: 0))),
            next(200, (IndexPath(row: 1, section: 0))),
            next(300, (IndexPath(row: 2, section: 0))),
            next(400, (IndexPath(row: 80, section: 0))),
            ]).asObservable()

        let input = createInput(itemSelected: selectTrigger)
        let output = presenter.transform(input)
        output.cancelable
            .disposed(by: self.disposeBag)
        output.news.drive().disposed(by: self.disposeBag)
        scheduler.scheduleAt(0, action: {
            output.cancelable
                .disposed(by: self.disposeBag)
        })
        scheduler.start()

        XCTAssertEqual(self.router.didMoveToDetails, 3)
    }

    private func createTrigger() -> Observable<()> {
        return self.scheduler.createHotObservable([
            next(100, ()),
            next(200, ()),
            next(300, ())
            ])
            .do(onNext: {
                self.interactor.testCase.next()
            })
    }

    private func createInput(refreshTrigger: Driver<Void> = Observable.just(Void()).asDriver(onErrorJustReturn: ()),
                             itemSelected: Observable<IndexPath> = Observable.just(IndexPath(row: 0, section: 0))) -> NewsPresenter.Input {
        return NewsPresenter.Input(refreshTrigger: refreshTrigger, itemSelected: itemSelected)
    }
}
