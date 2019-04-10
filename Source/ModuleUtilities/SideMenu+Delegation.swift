//
//  SideMenu+Delegation.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 10/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension DaznUserInterface {

    func configureSideMenu() {
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(menuTableView)
        menuTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor)
        menuTableView
            .bottomAnchor
            .constraint(lessThanOrEqualTo: view.bottomAnchor)
            .isActive = true

        menuTableView.isHidden = true
        
        bindSideMenu()
    }

    private func bindSideMenu() {
        let sideMenuDriver = Driver.just(sideMenuData)
        Driver.combineLatest(sideMenuDriver, menuTableView.rx.itemSelected.asDriver())
            .drive(onNext: { [weak self] sideMenuData, indexPath in
                self?.menuTableView.isHidden = true
                let menuItem = sideMenuData[safe: indexPath.item]
                self?.navigateTo(menuItem?.module)
            }).disposed(by: disposeBag)
        driveSideMenu(sideMenuDriver)
    }

    private func driveSideMenu(_ driver: Driver<[SideMenuViewModel]>) {
        driver.drive(
            menuTableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)
        ) { _, item, cell in
            cell.selectionStyle = .none
            cell.textLabel?.text = item.title
        }.disposed(by: disposeBag)
    }

    private func navigateTo(_ moduleName: String?) {
        guard let module = AppModules(rawValue: moduleName ?? "") else {
            print("Invalid AppModule name")
            return
        }
        let build = module.build()
        if build.view.classForCoder == self.classForCoder {
            return
        }
        module.showAsAppRootVC()
    }
}

extension DaznUserInterface {
    private var sideMenuData: [SideMenuViewModel] {
        return PlistSerializer.decode([SideMenuViewModel].self, fromFile: MagicValues.SideMenuPlist) ?? []
    }
}
