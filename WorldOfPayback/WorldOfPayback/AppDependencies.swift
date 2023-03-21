//
//  AppDependencies.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 14/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

final class AppDependencies {

    lazy var apiClient = DefaultHTTPClient(reachability: reachability, configuration: .staging)
    
    lazy var reachability = ReachabilityChecker()

    lazy var transactionService = FakeTransactionService()
}
