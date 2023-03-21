//
//  MultipleSelectionRow.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 15/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import SwiftUI

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
