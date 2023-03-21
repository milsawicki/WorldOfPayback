//
//  TransactionServiceStub.swift
//  WorldOfPaybackTests
//
//  Created by Milan Sawicki on 20/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation
@testable import WorldOfPayback

class TransactionServiceStub: TransactionServiceProtocol {
    var httpClient: HTTPClient = DefaultHTTPClient(reachability: ReachabilityCheckerStub(), configuration: .production)
    
    var expectedTransactionList = TransactionList(items: [])
    func getTransactions() async throws -> TransactionList { expectedTransactionList }
}
