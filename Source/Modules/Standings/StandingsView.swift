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
}

// MARK: - StandingsView API
extension StandingsView: StandingsViewApi {

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchData().drive().disposed(by: disposeBag)
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
