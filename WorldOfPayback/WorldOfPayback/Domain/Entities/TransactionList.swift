//
//  TransactionListDTO.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 13/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

struct TransactionList: Codable {
    let items: [Transaction]
}
