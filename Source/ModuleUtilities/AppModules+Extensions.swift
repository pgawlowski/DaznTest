//
//  AppModules+Extensions.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import UIKit

extension AppModules {
    var upperCasedName: String {
        return rawValue.prefix(1).uppercased() + rawValue.dropFirst()
    }

    private static var window: UIWindow {
        guard let window = UIApplication.shared.delegate?.window as? UIWindow else {
            #if DEBUG
            //swiftlint:disable fatal_error
            fatalError("NO WINDOW!")
            //swiftlint:enable fatal_error
            #endif
        }
        return window
    }

    func showAsAppRootVC(embedInNavController: Bool = true, setupData: Any? = nil) {
        let viewToShow = embedInNavController
            ? embedNavigationController(setupData)
            : buildViewController(setupData)
        AppModules.setRootViewController(viewToShow)
    }

    func buildViewController(_ setupData: Any? = nil) -> UIViewController {
        return buildAppModule(setupData)
    }
}

private extension AppModules {
    private func buildAppModule() -> UIViewController {
        let module = self.build()
        return module.view
    }

    private static func setRootViewController(_ viewToShow: UIViewController) {
        let options = UIWindow.TransitionOptions(direction: .fade, style: .easeIn)
        AppModules.window.setRootViewController(viewToShow, options: options)
    }

    private func embedNavigationController(_ setupData: Any? = nil) -> UINavigationController {
        let rootVC: UIViewController = self.buildViewController(setupData)
        return UINavigationController(rootViewController: rootVC)
    }

    private func buildAppModule(_ setupData: Any? = nil) -> UIViewController {
        let module = self.build()
        if let data = setupData {
            module.router._presenter.setupView(data: data)
        }
        module.view.view.layoutIfNeeded()
        return module.view
    }
}
