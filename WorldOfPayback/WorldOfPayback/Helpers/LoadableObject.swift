//
//  LoadableObject.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 15/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

enum LoadingState<Result> {
    case error(Error)
    case success(Result)
    case loading
}

protocol LoadableObject {
    associatedtype Result
    var state: LoadingState<Result> { get }
}
