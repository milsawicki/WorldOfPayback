//
//  Router.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 20/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

enum Router {
    case transactions

    var path: String {
        switch self {
        case .transactions:
            return "/transactions"
        }
    }
}
