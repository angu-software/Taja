//
//  ContentView.swift
//  Taja
//
//  Created by Andreas Guenther on 20.12.24.
//

import SwiftUI

import TajaMemoryUIComponents

struct ContentView: View {

    @State
    var memoryCards: [MemoryCard]

    init(cards: [MemoryCard] = [MemoryCard(content: .init(id: "1")),
                                MemoryCard(content: .init(id: "1")),
                                MemoryCard(content: .init(id: "2")),
                                MemoryCard(content: .init(id: "2"))]) {
        self.memoryCards = cards
    }

    var body: some View {
        GridLayout(alignment: .center,
                   horizontalSpacing: 4,
                   verticalSpacing: 4) {
            ForEach(0..<2) { rowNumber in
                GridRow(alignment: .center) {
                    ForEach(0..<2) { columnNumber in
                        MemoryCardView(state: memoryCards[rowNumber + columnNumber].state)
                    }
                }
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
