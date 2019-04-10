//
//  NewsDetailsPresenter.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation
import Viperit

// MARK: - NewsDetailsPresenter Class
final class NewsDetailsPresenter: Presenter {
    private var webUrl: URL?

    override func setupView(data: Any) {
        guard let data = data as? URL else { return }
        webUrl = data
    }

    override func viewHasLoaded() {
        super.viewHasLoaded()

        if let url = webUrl {
            view.setupWebView(url)
        }
    }
}

// MARK: - NewsDetailsPresenter API
extension NewsDetailsPresenter: NewsDetailsPresenterApi {
}

// MARK: - NewsDetails Viper Components
private extension NewsDetailsPresenter {
    var view: NewsDetailsViewApi {
        // swiftlint:disable force_cast
        return _view as! NewsDetailsViewApi
        // swiftlint:enable force_cast
    }
    var interactor: NewsDetailsInteractorApi {
        // swiftlint:disable force_cast
        return _interactor as! NewsDetailsInteractorApi
        // swiftlint:enable force_cast
    }
    var router: NewsDetailsRouterApi {
        // swiftlint:disable force_cast
        return _router as! NewsDetailsRouterApi
        // swiftlint:enable force_cast
    }
}
