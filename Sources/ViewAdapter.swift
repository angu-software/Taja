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
    private(set) var cards: [MemoryCard] = []

    private let gameController: MemoryCardGameController

    init(cards: [MemoryCard] = [MemoryCard(id: "1",
                                           content: .init(id: "photo01")),
                                MemoryCard(id: "2",
                                           content: .init(id: "photo01")),
                                MemoryCard(id: "3",
                                           content: .init(id: "photo02")),
                                MemoryCard(id: "4",
                                           content: .init(id: "photo02"))]) {
        var cards = cards
        cards.shuffle()

        self.gameController = MemoryCardGameController(cards: cards)
        self.cards = cards
    }

    func didTapCard(_ card: MemoryCard) {
        gameController.didSelectCard(card)
        cards = gameController.cards
    }
}
