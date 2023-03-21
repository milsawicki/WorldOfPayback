//
//  ContentView.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 17/02/2023.
//

import SwiftUI
struct TransactionListView: View {
    @StateObject var viewModel: TransactionsViewModel

    @State var shouldShowOptions = false
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .success:
                    if viewModel.transactions.isEmpty {
                        ErrorView(
                            errorMessage: Localizable.TransactionList.noData,
                            image: Image(systemName: "doc.plaintext")
                        )
                    }
                    scrollableListView
                case .loading:
                    loadingView
                case .error:
                    ErrorView(errorMessage: Localizable.Error.offline) {
                        Task {
                            await viewModel.fetchTransactions()
                        }
                    }
                }
            }
        }
        .navigationTitle(Text(Localizable.TransactionList.transactions + " 💸"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    shouldShowOptions.toggle()
                } label: {
                    Image(systemName: "line.horizontal.3.decrease")
                    Text(Localizable.Common.filter)
                }
            }
            ToolbarItem(placement: .bottomBar) { footerView }
        }
        .sheet(isPresented: $shouldShowOptions) {
            Text(Localizable.Common.filter)
                .font(.subheadline.weight(.medium))
                .padding()
            List {
                ForEach(Array(viewModel.availableCategories), id: \.self) { category in
                    MultipleSelectionRow(
                        title: String(category),
                        isSelected: viewModel.selectedCategories.contains(category)
                    ) { viewModel.toggle(category: category) }
                }
            }
            .presentationDetents([.height(300)])
        }
        .task {
            await viewModel.fetchTransactions()
        }
    }

    var scrollableListView: some View {
        ScrollView {
            ForEach(viewModel.transactions, id: \.self) { transaction in
                NavigationLink(value: transaction) {
                    TransactionItemView(viewModel: .init(transaction: transaction))
                }
            }
            .navigationDestination(for: Transaction.self, destination: { transaction in
                TransactionDetailsView(viewModel: .init(transaction: transaction))
            })
        }
    }

    var footerView: some View {
        HStack {
            Image(systemName: "equal.circle")
            Text("Sum:")
                .font(.subheadline)
            Text("\(viewModel.transactionsSum)")
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }

    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView(Localizable.Common.fetchingData)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionsViewModel(service: FakeTransactionService()))
    }
}
