//
//  Date+Extensions.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxSwift
import Foundation

struct MagicValues {
    static let fullDateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
}

struct ScoresValues {
    static let period: RxTimeInterval = Double(30)
    static let repeatMaxCount: UInt = UInt(15)
    static let repeatTime: Double = Double(2.0)
}
