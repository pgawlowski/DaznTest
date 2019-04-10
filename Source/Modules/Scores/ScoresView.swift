
//
//  ScoresView.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit
import Viperit

// MARK: ScoresView Class
final class ScoresView: DaznUserInterface {

    @IBOutlet weak var tableView: IntrinsicTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        bindPresenter()
    }

    func configureTableView() {
        tableView.refreshControl = refreshControl
        tableView.register(nibWithCellClass: ScoresTableViewCell.self)
        tableView.allowsSelection = false
    }

    func bindPresenter() {
        let input = ScoresPresenter.Input(refreshTrigger: refreshTrigger)

        let output = presenter.transform(input)
        output.cancelable.disposed(by: disposeBag)
        driveTableView(output.scores)
    }

    func driveTableView(_ driver: Driver<[ScoreSectionModel]>) {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, MatchDto>>(
            configureCell: { _, tableView, _, item in
                let cell = tableView.dequeueReusableCell(withClass: ScoresTableViewCell.self)
                cell.setup(item)
                return cell
        })
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }

        driver.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - ScoresView API
extension ScoresView: ScoresViewApi {

}

extension ScoresView {
    var displayData: ScoresDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! ScoresDisplayData
        // swiftlint:enable force_cast
    }
}

// MARK: - ScoresView Viper Components API
private extension ScoresView {
    var presenter: ScoresPresenterApi {
        // swiftlint:disable force_cast
        return _presenter as! ScoresPresenterApi
        // swiftlint:enable force_cast
    }
}
