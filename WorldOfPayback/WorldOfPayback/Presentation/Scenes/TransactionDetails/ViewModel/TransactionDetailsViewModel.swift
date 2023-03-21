//
//  TransactionDetailsViewModel.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 20/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

class TransactionDetailsViewModel: ObservableObject {
    var displayName: String
    var description: String
    init(transaction: Transaction) {
        displayName = transaction.partnerDisplayName
        description = transaction.transactionDetail.description ?? " - "
    }
}
