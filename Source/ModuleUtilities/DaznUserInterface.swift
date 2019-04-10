//
//  DaznUserInterface.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Viperit

public protocol DaznUserInterfaceProtocol {
    func setupID()
    func setupTranslations()
    func startRefreshing()
    func endRefreshing()
    func dropdownMenuAction()

    func showError(_ error: Error)
    func showError(_ error: Error, completion: (() -> Swift.Void)?)
}

open class DaznUserInterface: UserInterface, DaznUserInterfaceProtocol {

    var disposeBag = DisposeBag()
    var menuTableView = IntrinsicTableView()

    private var isRefreshControl = false

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.blue
        isRefreshControl = true
        return refreshControl
    }()

    lazy var refreshTrigger: Driver<Void> = {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
        let pull = refreshControl.rx
            .controlEvent(.valueChanged)
            .asDriver()
        return Driver.merge(viewWillAppear, pull)
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupID()
        setupTranslations()
        addMenuButton()
        configureSideMenu()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
            refreshControl.beginRefreshing()
        }
    }

    open func startRefreshing() {
        if isRefreshControl {
            refreshControl.beginRefreshing()
        }
    }

    open func endRefreshing() {
        if isRefreshControl {
            refreshControl.endRefreshing()
        }
    }

    @objc open func dropdownMenuAction() {
        menuTableView.isHidden = !menuTableView.isHidden
    }

    @objc dynamic
    open func setupID() {
        print("Setup id not implemented")
    }

    @objc dynamic
    open func setupTranslations() {
        print("Setup translations not implemented")
    }

    @objc dynamic
    open func showError(_ error: Error) {
        print(error.localizedDescription)
    }

    @objc dynamic
    open func showError(_ error: Error, completion: (() -> Void)?) {

    }
}

extension DaznUserInterface {
    public func addMenuButton() {
        guard let image = UIImage(awesomeType: .caretDown, textColor: .gray) else { return }
        let menuButton = addRightBarButtonItem(image: image)
        menuButton.addTargetForAction(self, action: #selector(dropdownMenuAction))
    }
}
