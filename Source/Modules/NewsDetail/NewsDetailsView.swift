//
//  NewsDetailsView.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Viperit
import SVProgressHUD
import WebKit

//MARK: NewsDetailsView Class
final class NewsDetailsView: DaznUserInterface {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }

}

//MARK: - NewsDetailsView API
extension NewsDetailsView: NewsDetailsViewApi {
    func setupWebView(_ url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension NewsDetailsView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}

extension NewsDetailsView {
    var displayData: NewsDetailsDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! NewsDetailsDisplayData
        // swiftlint:enable force_cast
    }
}

// MARK: - NewsDetailsView Viper Components API
private extension NewsDetailsView {
    var presenter: NewsDetailsPresenterApi {
        // swiftlint:disable force_cast
        return _presenter as! NewsDetailsPresenterApi
        // swiftlint:enable force_cast
    }
}
