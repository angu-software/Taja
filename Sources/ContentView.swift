//
//  ContentView.swift
//  Taja
//
//  Created by Andreas Guenther on 20.12.24.
//

import SwiftUI

import TajaMemoryUIComponents

struct ContentView: View {
    var body: some View {
        GridLayout(alignment: .center, horizontalSpacing: 4, verticalSpacing: 4) {
            GridRow(alignment: .center) {
                MemoryCardView()
                MemoryCardView()
            }
            GridRow(alignment: .center) {
                MemoryCardView()
                MemoryCardView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

extension MemoryCardView {

    init() {
        self.init(frontImage: .memoryCardDuck,
                  backImage: .memoryCardBack)

    }
}
