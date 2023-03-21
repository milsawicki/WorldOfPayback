//
//  TransactionsItemViewModel.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 14/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

struct TransactionsItemViewModel: Hashable {
    var displayName: String
    var description: String?
    var bookingDate: String
    var amount: String?
    var category: Int
    
    init(transaction: Transaction) {
        displayName = transaction.partnerDisplayName
        description = transaction.transactionDetail.description
        bookingDate = transaction.transactionDetail.bookingDate.formatted(date: .abbreviated, time: .shortened)

        if let amount = transaction.transactionDetail.value?.amount,
           let currency = transaction.transactionDetail.value?.currency.rawValue {
            self.amount = "\(amount) \(currency)"
        }
        category = transaction.category
    }
}
