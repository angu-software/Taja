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
            ForEach(0..<6) { rowNumber in
                GridRow(alignment: .center) {
                    ForEach(0..<3) { columnNumber in
                        let cardIndex = viewAdapter.cardIndex(forRow: rowNumber,
                                                              column: columnNumber)
                        let card = memoryCards[cardIndex]
                        return MemoryCardView(memoryCard: card)
                            .onTapGesture {
                                viewAdapter.didTapCard(card)
                            }
                    }
                }
            }
        }
       .toolbar(content: {
           ToolbarItem(placement: .bottomBar) {
               Button(action: {
                   viewAdapter.startNewGame()
               }) {
                   Text("New Game")
               }
           }
       })
       .padding()
    }
}

#Preview {
    ContentView()
}

import TajaMemory

extension MemoryCardView {

    init(memoryCard: MemoryCard) {
        let frontImage = UIImage(named: memoryCard.content.id)!

        self.init(frontImage: frontImage,
                  backImage: .memoryCardBack,
                  state: memoryCard)
    }
}
