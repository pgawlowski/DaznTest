//
//  NewsView.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import SwifterSwift
import UIKit
import Viperit

// MARK: NewsView Class
final class NewsView: DaznUserInterface {
    @IBOutlet weak var tableView: IntrinsicTableView!
}

// MARK: - NewsView API
extension NewsView: NewsViewApi {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        bindPresenter()
    }

    func configureTableView() {
        tableView.refreshControl = refreshControl
        tableView.register(nibWithCellClass: NewsTableViewCell.self)
    }

    func bindPresenter() {
        let itemSelected = tableView.rx.itemSelected.asObservable()
        let input = NewsPresenter.Input(refreshTrigger: refreshTrigger,
                                        itemSelected: itemSelected)

        let output = presenter.transform(input)
        output.cancelable.disposed(by: disposeBag)
        driveTableView(output.news)
    }

    func driveTableView(_ driver: Driver<[RssItemDto]>) {
        driver.drive(
            tableView.rx.items(cellIdentifier: "NewsTableViewCell", cellType: NewsTableViewCell.self)
        ) { _, item, cell in
            cell.setup(item)
        }.disposed(by: disposeBag)
    }
}

extension NewsView {
    var displayData: NewsDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! NewsDisplayData
        // swiftlint:enable force_cast
    }
}

// MARK: - NewsView Viper Components API
private extension NewsView {
    var presenter: NewsPresenterApi {
        // swiftlint:disable force_cast
        return _presenter as! NewsPresenterApi
        // swiftlint:enable force_cast
    }
}
