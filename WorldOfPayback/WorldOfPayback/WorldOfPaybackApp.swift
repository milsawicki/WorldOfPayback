//
//  WorldOfPaybackApp.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 17/02/2023.
//

import SwiftUI

@main
struct WorldOfPaybackApp: App {
    let dependencies = AppDependencies()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TransactionListView(
                    viewModel: TransactionsViewModel(service: dependencies.transactionService)
                )
            }
        }
    }
}
