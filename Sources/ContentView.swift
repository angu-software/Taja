//
//  ContentView.swift
//  Taja
//
//  Created by Andreas Guenther on 20.12.24.
//

import SwiftUI

import TajaMemoryUIComponents

struct ContentView: View {

    private var cards: [MemoryCardView]

    init(cards: [MemoryCardView] = [MemoryCardView(),
                                    MemoryCardView(),
                                    MemoryCardView(),
                                    MemoryCardView()]) {
        self.cards = cards
    }

    var body: some View {
        GridLayout(alignment: .center,
                   horizontalSpacing: 4,
                   verticalSpacing: 4) {
            ForEach(0..<2) { rowNumber in
                GridRow(alignment: .center) {
                    ForEach(0..<2) { columnNumber in
                        cards[rowNumber + columnNumber]
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
