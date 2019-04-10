//
//  PlistSerializer.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 10/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation

class PlistSerializer {
    class func decode<T>(_ type: T.Type, fromFile filename: String) -> T? where T: Decodable {
        guard let filePath = Bundle.main.url(forResource: filename, withExtension: "plist") else {
            print("Can't find \(filename) plist file!")
            return nil
        }
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = PropertyListDecoder()
            let results = try decoder.decode(type, from: data)
            return results
        } catch {
            print(error.localizedDescription)
            #if DEBUG
            //swiftlint:disable fatal_error
            fatalError()
            //swiftlint:enable fatal_error
            #endif
        }
    }

    class func encodeToJsonString<T>(_ model: T) -> String? where T: Codable {
        do {
            let json = try JSONEncoder().encode(model)
            return String(bytes: json, encoding: .utf8)
        } catch let error {
            print(error)
            return nil
        }
    }
}
