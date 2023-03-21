//
//  TransactionDetailsViewModelTests.swift
//  WorldOfPaybackTests
//
//  Created by Milan Sawicki on 20/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

@testable import WorldOfPayback
import XCTest

final class TransactionDetailsViewModelTests: XCTestCase {
    func testInitialization() {
        // given
        let expectedDisplayName = "displayName"
        let expectedDescription = "description"

        let transaction = Transaction(
            partnerDisplayName: expectedDisplayName,
            category: 1,
            transactionDetail: TransactionDetail(
                description: expectedDescription,
                bookingDate: Date(),
                value: nil
            )
        )

        // when
        let transactionsViewModel = TransactionDetailsViewModel(transaction: transaction)
        // then
        XCTAssertNotNil(transactionsViewModel, "The transactions view model should not be nil.")
        XCTAssertTrue(transactionsViewModel.displayName == expectedDisplayName, "The transaction display name is not as expected.")
    }
}
