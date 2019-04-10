//
//  ApiEndpoints.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Moya

enum ApiEndpoints: ApiBase {
    case getLatestsNews
    case getScores
    case getStandings
}

extension ApiEndpoints: TargetType {
    var method: Method {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getLatestsNews:
            return "latestnews.xml"
        case .getScores:
            return "scores.xml"
        case .getStandings:
            return "standings.xml"
        }
    }

    var parameters: Codable? {
        switch self {
        default:
            return nil
        }
    }
}

extension ApiEndpoints {
    var sampleData: Data {
        var response: Data?
        switch self {
        default:
            response = nil
        }
        return response ?? "Default sample data to return".data(using: .utf8)!
    }
}
