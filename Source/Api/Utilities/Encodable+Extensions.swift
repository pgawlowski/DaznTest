//
//  Encodable+Extensions.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import XMLParsing
import RxSwift
import Foundation
import Moya

extension Decodable {

    private static var dateDecodingStrategy: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = MagicValues.fullDateFormat
        return df
    }

    static var xmlDecoder: XMLDecoder {
        let decoder = XMLDecoder()
        decoder.dateDecodingStrategy = .formatted(Self.dateDecodingStrategy)
        return decoder
    }

//    static func xmlDecode(from data: Data) throws -> Self {
//        do {
//            return try xmlDecoder.decode(Self.self, from: data)
//        } catch {
//            throw error
//        }
//    }
//
////    static func decode<T>(from dictionary: [String: Any]) throws -> T where T: Decodable {
////        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
////        return try xmlDecoder.decode(Self, from: data)
////    }
////
////    static func loadFromFile(name: String, type: String = "xml") throws -> Self {
////        do {
////            let data = try getData(name: name, type: type)
////            return try Self.decode(from: data)
////        } catch {
////            throw error
////        }
////    }
////
////    static func loadArrayFromFile(name: String, type: String = "xml") throws -> [Self] {
////        do {
////            let data = try getData(name: name, type: type)
////            return try [Self].decode(from: data)
////        } catch {
////            throw error
////        }
////    }

//    private static func getData(name: String, type: String) throws -> Data {
//        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
//            throw NSError(domain: "File path inaccessible", code: 0)
//        }
//        guard let data = NSData(contentsOfFile: path) else {
//            throw NSError(domain: "Content of file inaccesible", code: 0)
//        }
//
//        return data as Data
//    }
}

internal extension Encodable {

    private static var dateEcodingStrategy: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return df
    }

    private var xmlEncoder: XMLEncoder {
        let encoder = XMLEncoder()
        encoder.dateEncodingStrategy = .formatted(Self.dateEcodingStrategy)

        return encoder
    }

    var dictionary: [String: Any]? {
        guard let data = try? xmlEncoder.encode(self, withRootKey: "") else { return nil }
        return (try? JSONSerialization
            .jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }
}
