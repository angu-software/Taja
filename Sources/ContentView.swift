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
        GridLayout(alignment: .center,
                   horizontalSpacing: 4,
                   verticalSpacing: 4) {
            GridRow(alignment: .center) {
                MemoryCardView()
                MemoryCardView(state: .revealed)
            }
            GridRow(alignment: .center) {
                MemoryCardView(state: .revealed)
                MemoryCardView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

import TajaMemory

extension MemoryCardView {

    init(state: MemoryCard.State = .concealed) {
        self.init(frontImage: .memoryCardDuck,
                  backImage: .memoryCardBack,
                  state: MemoryCard(content: .init(id: "1"),
                                    state: state))

    }
}
