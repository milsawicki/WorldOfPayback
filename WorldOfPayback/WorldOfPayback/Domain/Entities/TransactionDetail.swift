//
//  TransactionDetail.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 14/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

struct TransactionDetail: Codable, Hashable {
    let description: String?
    let bookingDate: Date
    let value: Value?
}

struct Value: Codable, Hashable {
    let amount: Int
    let currency: Currency
}

enum Currency: String, Codable {
    case pbp = "PBP"
}
