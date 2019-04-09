//
//  StandingsView.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Viperit

// MARK: StandingsView Class
final class StandingsView: DaznUserInterface {
    @IBOutlet weak var tableView: IntrinsicTableView!
}

// MARK: - StandingsView API
extension StandingsView: StandingsViewApi {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        bindPresenter()
    }

    func configureTableView() {
        tableView.refreshControl = refreshControl
        tableView.register(nibWithCellClass: StandingsTableViewCell.self)
        tableView.allowsSelection = false
    }

    func bindPresenter() {
        let input = StandingsPresenter.Input(refreshTrigger: refreshTrigger)

        let output = presenter.transform(input)
        output.cancelable.disposed(by: disposeBag)
        driveTableView(output.standings)
    }

    func driveTableView(_ driver: Driver<[RankingDto]>) {
        driver.drive(
            tableView.rx.items(cellIdentifier: "StandingsTableViewCell", cellType: StandingsTableViewCell.self)
        ) { _, item, cell in
            cell.setup(item)
        }.disposed(by: disposeBag)

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension StandingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = StandingsHeader()
        header.frame = .zero
        return header
    }
}

extension StandingsView {
    var displayData: StandingsDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! StandingsDisplayData
        // swiftlint:enable force_cast
    }
}

// MARK: - StandingsView Viper Components API
private extension StandingsView {
    var presenter: StandingsPresenterApi {
        // swiftlint:disable force_cast
        return _presenter as! StandingsPresenterApi
        // swiftlint:enable force_cast
    }
}
