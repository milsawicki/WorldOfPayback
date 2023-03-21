//
//  RequestError.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 05/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

enum APIError: Error {
    case decode
    case invalidURL
    case noResponse
    case offline
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        default:
            return "Unknown error"
        }
    }
}
