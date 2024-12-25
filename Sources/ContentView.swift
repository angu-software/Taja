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
                        MemoryCardView(memoryCard: memoryCards[rowNumber + columnNumber])
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

    init(memoryCard: MemoryCard) {
        self.init(frontImage: .memoryCardDuck,
                  backImage: .memoryCardBack,
                  state: memoryCard)
    }
}
