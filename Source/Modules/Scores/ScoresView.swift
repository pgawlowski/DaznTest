
//
//  ScoresView.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Viperit

// MARK: ScoresView Class
final class ScoresView: DaznUserInterface {
}

// MARK: - ScoresView API
extension ScoresView: ScoresViewApi {

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchData().drive().disposed(by: disposeBag)
    }

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
