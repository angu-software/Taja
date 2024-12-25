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
            GridRow(alignment: .center) {
                cards[0]
                cards[1]
            }
            GridRow(alignment: .center) {
                cards[2]
                cards[3]
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
