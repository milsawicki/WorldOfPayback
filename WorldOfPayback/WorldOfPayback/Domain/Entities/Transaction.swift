//
//  TransactionDTO.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 13/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

struct Transaction: Codable, Hashable {
    let partnerDisplayName: String
    let category: Int
    let transactionDetail: TransactionDetail
}
