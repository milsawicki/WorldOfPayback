//
//  TransactionItemView.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 13/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import SwiftUI

struct TransactionItemView: View {
    @State var viewModel: TransactionsItemViewModel

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.displayName)
                    .font(.title)
                Spacer()
            }
            .padding([.trailing, .leading, .top], 16)
            if let description = viewModel.description {
                HStack {
                    Text(description)
                        .font(.title3)
                    Spacer()
                }.padding([.trailing, .leading], 16)
            }
            HStack {
                Image(systemName: "stopwatch")
                    .foregroundColor(.secondary)
                Text(viewModel.bookingDate)
                Spacer()
                Image(systemName: "creditcard")
                    .foregroundColor(.secondary)
                Text(viewModel.amount ?? "")
            }
            .padding([.trailing, .leading, .bottom], 16)
        }
        .background(.regularMaterial)
        .cornerRadius(8)
    }
}
