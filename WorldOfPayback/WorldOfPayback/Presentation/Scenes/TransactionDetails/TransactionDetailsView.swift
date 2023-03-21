//
//  TransactionDetailsView.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 15/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import SwiftUI

struct TransactionDetailsView: View {
    
    @StateObject var viewModel: TransactionDetailsViewModel

    var body: some View {
        VStack(alignment: .center) {
            Text(viewModel.displayName).font(.headline)
            Text(viewModel.description).font(.subheadline)
        }
    }
}
