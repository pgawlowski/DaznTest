//
//  DaznTest.swift
//  DaznTest
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import XCTest

extension XCTestCase {
    internal func formatted(name: String) -> String {
        return "-[\(String(describing: self.classForCoder)) \(name)]"
    }
}
