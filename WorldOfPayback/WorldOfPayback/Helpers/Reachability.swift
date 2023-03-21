//
//  Reachability.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 14/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation
import Reachability

protocol ReachabilityCheckable {
    var isOnline: Bool { get }
}

class ReachabilityChecker: ReachabilityCheckable {
    var isOnline: Bool {
        (try? Reachability().connection != .unavailable) ?? false
    }
}
