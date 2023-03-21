//
//  OfflineView.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 14/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    @State var errorMessage: String = ""
    @State var image: Image = Image(systemName: "nosign")
    var action: (() -> Void)?

    var body: some View {
        VStack {
            Spacer()
            image
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundColor(.teal)
            Text(errorMessage)
            if let action = action {
                Button {
                    action()
                } label: {
                    Text(Localizable.Common.retry)
                }
                .buttonStyle(.bordered)
                Spacer()
            }
        }
    }
}

struct OfflineView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(action: {})
    }
}
