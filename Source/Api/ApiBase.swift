//
//  ApiBase.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Moya

protocol ApiBase: AccessTokenAuthorizable, TargetType {
    var baseURL: URL { get }
    var task: Task { get }
    var headers: [String: String]? { get }
    var sampleData: Data { get }
    var parameterEncoding: ParameterEncoding { get }
    var method: Moya.Method { get }
    var parameters: Codable? { get }
}

extension ApiBase {
    var baseURL: URL {
        return URL(string: "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/")!
    }

    var authorizationType: AuthorizationType {
        return .bearer
    }

    var parameters: Codable? {
        return nil
    }

    var parameterEncoding: ParameterEncoding {
        switch self.method {
        case .post,
             .put,
             .patch:
            return JSONEncoding.default
        case .get,
             .delete:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var task: Task {
        switch self.method {
        case .post,
             .patch:
            return .requestJSONEncodable(self.parameters ?? ["": ""])
        case .put:
            return .requestParameters(parameters: self.parameters?.dictionary ?? ["": ""],
                                      encoding: self.parameterEncoding)
        case .get,
             .delete:
            if let params = self.parameters?.dictionary {
                return .requestParameters(parameters: params, encoding: URLEncoding.default)
            }
            return .requestPlain
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/xml"
        ]
    }
}

extension TargetType {
    var sampleData: Data {
        switch self {
        default:
            return "Default sample data to return".data(using: .utf8)!
        }
    }

    // MARK: - Provider support
    func stubbedResponse(filename: String, type: String = "json") -> Data? {
        guard let path = Bundle.main.path(forResource: filename, ofType: type) else { return nil }
        guard let data = NSData(contentsOfFile: path) else { return nil }

        return Data(referencing: data)
    }

    func url(_ route: TargetType) -> String {
        return route.baseURL.appendingPathComponent(route.path).absoluteString
    }
}
