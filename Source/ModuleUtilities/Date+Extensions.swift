//
//  Date+Extensions.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation

extension Date {

    static func dateWith(_ format: String, dateString: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: dateString)
    }

}

extension String {
    static func dateFrom(_ format: String, date: Date) -> String? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: date)
    }

}
