//
//  TransactionsViewModelTests.swift
//  WorldOfPaybackTests
//
//  Created by Milan Sawicki on 17/02/2023.
//

@testable import WorldOfPayback
import XCTest

final class TransactionsViewModelTests: XCTestCase {
    
    let exptectedTransactions = [
        Transaction(
            partnerDisplayName: "test",
            category: 1,
            transactionDetail: TransactionDetail(
                description: "test",
                bookingDate: Date(),
                value: Value(amount: 100, currency: .pbp)
            )
        ),
        Transaction(
            partnerDisplayName: "test",
            category: 6,
            transactionDetail: TransactionDetail(
                description: "test",
                bookingDate: Date(),
                value: Value(amount: 200, currency: .pbp)
            )
        ),
        Transaction(
            partnerDisplayName: "test",
            category: 9,
            transactionDetail: TransactionDetail(
                description: "test",
                bookingDate: Date(),
                value: Value(amount: 300, currency: .pbp)
            )
        )
    ]
    func testInitialization() {

        // when
        let transactionsViewModel = TransactionsViewModel(service: TransactionServiceStub())
        // then
        XCTAssertNotNil(transactionsViewModel, "The transactions view model should not be nil.")
    }

    func testFetchingTransactions() async {
        // given
        let service = TransactionServiceStub()
        service.expectedTransactionList = TransactionList(items: exptectedTransactions)
        let transactionsViewModel = TransactionsViewModel(service: service)

        // when
        await transactionsViewModel.fetchTransactions()

        // then
        XCTAssertNotEqual(transactionsViewModel.transactionsSum, 0, "Transactions sum should not be 0")
        XCTAssertEqual(transactionsViewModel.availableCategories, [1, 9, 6])
        XCTAssertEqual(transactionsViewModel.transactionsSum, 600)
        XCTAssertEqual(transactionsViewModel.selectedCategories, [1, 9, 6], "All categories should be selected by default.")
    }
    
    func testTogglingCategories() async {
        let service = TransactionServiceStub()
        service.expectedTransactionList = TransactionList(items: exptectedTransactions)
        let transactionsViewModel = TransactionsViewModel(service: service)
        
        await transactionsViewModel.fetchTransactions()
        let toggledCategory = 6
        transactionsViewModel.toggle(category: toggledCategory)
        
        XCTAssertNotEqual(transactionsViewModel.transactionsSum, 0, "Transactions sum should not be 0")
        XCTAssertEqual(transactionsViewModel.availableCategories, [1, 9, 6])
        XCTAssertEqual(transactionsViewModel.transactionsSum, 400)
        
        transactionsViewModel.toggle(category: 1)
        transactionsViewModel.toggle(category: 9)
        XCTAssertEqual(transactionsViewModel.transactionsSum, 0, "Transactions sum should be 0 when list is empty")
        XCTAssertEqual(transactionsViewModel.selectedCategories, [], "There should be no selected categories")
        
        transactionsViewModel.toggle(category: 1)
        XCTAssertNotEqual(transactionsViewModel.transactionsSum, 0, "Transactions sum should be not 0 when list there are elements visible.")
        XCTAssertEqual(transactionsViewModel.selectedCategories, [1], "There should be 1 category visible.")
        XCTAssertEqual(transactionsViewModel.transactionsSum, 100)

    }
}
