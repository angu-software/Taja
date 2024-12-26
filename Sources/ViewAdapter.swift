//
//  ViewAdapter.swift
//  Taja
//
//  Created by Andreas Guenther on 26.12.24.
//

import SwiftUI

import TajaMemory

final class ViewAdapter: ObservableObject {

    @Published
    private(set) var cards: [MemoryCard]

    init(cards: [MemoryCard] = [MemoryCard(id: "1",
                                           content: .init(id: "C1")),
                                MemoryCard(id: "2",
                                           content: .init(id: "C1")),
                                MemoryCard(id: "3",
                                           content: .init(id: "C2")),
                                MemoryCard(id: "4",
                                           content: .init(id: "C2"))]) {
        self.cards = cards
    }

    func didTapCard(_ card: MemoryCard) {
        var card = card
        guard let cardIndex = cards.firstIndex(of: card) else {
            return
        }

        card.reveal()
        cards[cardIndex] = card
    }
}
