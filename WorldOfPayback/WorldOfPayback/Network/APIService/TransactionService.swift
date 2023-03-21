//
//  TransactionService.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 05/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

protocol TransactionServiceProtocol {
    var httpClient: HTTPClient { get set }
    func getTransactions() async throws -> TransactionList
}

struct TransactionService: TransactionServiceProtocol {
    var httpClient: HTTPClient
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getTransactions() async throws -> TransactionList {
        try await httpClient.sendRequest(
            endpoint: .transactions,
            responseModel: TransactionList.self
        )
    }
}

struct FakeTransactionService: TransactionServiceProtocol {
    var httpClient: HTTPClient = DefaultHTTPClient(reachability: ReachabilityChecker(), configuration: .production)

    func getTransactions() async throws -> TransactionList {
        try await Task.sleep(for: .seconds(1))
        if Int.random(in: 0..<10) == 5 {
            throw APIError.unknown
        }
        return try TransactionList.from(localJSON: "PBTransactions")
    }
}

enum JSONParseError: Error {
    case fileNotFound
    case dataInitialisation(error: Error)
    case decoding(error: Error)
}
