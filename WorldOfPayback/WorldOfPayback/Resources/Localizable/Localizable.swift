//
//  Localizable.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 13/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

enum Localizable {
    enum Common {
        static let sort = localized("common.sort")
        static let filter = localized("common.filter")
        static let fetchingData = localized("common.fetching-data")
        static let retry = localized("common.retry")

    }

    enum Error {
        static let offline = localized("error.offline")
    }
    
    enum TransactionList {
        static let transactions = localized("transaction-list.transactions")
        static let noData = localized("transaction-list.no-data")
    }
}

/// Returns localized string.
///
/// - Parameters:
///   - identifier: String identifier in localization table
func localized(_ identifier: String) -> String {
    NSLocalizedString(identifier, comment: "")
}
