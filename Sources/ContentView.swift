//
//  ContentView.swift
//  Taja
//
//  Created by Andreas Guenther on 20.12.24.
//

import SwiftUI

import TajaMemoryUIComponents

struct ContentView: View {

    @ObservedObject
    private var viewAdapter: ViewAdapter

    var memoryCards: [MemoryCard] {
        return viewAdapter.cards
    }

    init() {
        self.viewAdapter = ViewAdapter()
    }

    var body: some View {
        GridLayout(alignment: .center,
                   horizontalSpacing: 4,
                   verticalSpacing: 4) {
            ForEach(0..<2) { rowNumber in
                GridRow(alignment: .center) {
                    ForEach(0..<2) { columnNumber in
                        MemoryCardView(memoryCard: memoryCards[rowNumber * 2 + columnNumber])
                            .onTapGesture {
                                viewAdapter.didTapCard(memoryCards[rowNumber * 2 + columnNumber])
                            }
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
