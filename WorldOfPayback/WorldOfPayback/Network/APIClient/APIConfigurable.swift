//
//  APIConfigurable.swift
//

import Foundation

enum APIConfigurable {
    case production
    case staging

    var basePath: String {
        switch self {
        case .production:
            return "api.payback.com"
        case .staging:
            return "api-test.payback.com"
        }
    }
}
