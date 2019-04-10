//
//  UIViewController+Extensions.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 10/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import UIKit

extension UIViewController {
    public func addLeftBarButtonItem(title: String, _ accessibilityIdentifier: String? = nil) -> UIBarButtonItem {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = button
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = accessibilityIdentifier

        return button
    }

    public func addRightBarButtonItem(image: UIImage?, _ accessibilityIdentifier: String? = nil) -> UIBarButtonItem {
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = button
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = accessibilityIdentifier

        return button
    }
}

