//
//  TransactionsViewModel.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 05/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Combine
import Foundation

class TransactionsViewModel: ObservableObject, LoadableObject {
    @Published var transactionsSum = 0
    @Published var transactions = [Transaction]()
    @Published var selectedCategories: Set<Int> = []
    @Published var state = LoadingState<TransactionsViewModel>.loading
    var availableCategories: Set<Int> = []
    
    private let service: TransactionServiceProtocol
    private var transactionsSubject = CurrentValueSubject<[Transaction], Never>([])
    private var cancellables = Set<AnyCancellable>()
    private lazy var filteredTransactionsPublisher: AnyPublisher<[Transaction], Never> = {
        Publishers.CombineLatest($selectedCategories, transactionsSubject)
            .map { selection, transactions in
                transactions
                    .filter { selection.contains($0.category) }
                    .sorted { $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate }
            }
            .eraseToAnyPublisher()
    }()

    init(service: TransactionServiceProtocol) {
        self.service = service

        filteredTransactionsPublisher
            .assign(to: \.transactions, on: self)
            .store(in: &cancellables)

        filteredTransactionsPublisher
            .map { $0.compactMap { $0.transactionDetail.value?.amount }}
            .flatMap {
                $0
                    .publisher
                    .reduce(0) { acum, nextVal in acum + nextVal }
            }
            .assign(to: \.transactionsSum, on: self)
            .store(in: &cancellables)
    }

    @MainActor
    func fetchTransactions() async {
        state = .loading
        do {
            let items = try await service.getTransactions().items
            transactionsSubject.send(items)
            selectedCategories = Set(items.map { $0.category })
            availableCategories = Set(items.map { $0.category })
            state = .success(self)
        } catch let error {
            state = .error(error)
        }
    }

    func toggle(category: Int) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}
