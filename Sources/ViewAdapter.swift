//
//  ViewAdapter.swift
//  Taja
//
//  Created by Andreas Guenther on 26.12.24.
//

import SwiftUI

import TajaMemory

@MainActor
final class ViewAdapter: ObservableObject {

    @Published
    private(set) var cards: [MemoryCard] = []

    private var gameController: MemoryCardGameController

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

        observeCardChanges()
    }

    func startNewGame() {
        var cards = [MemoryCard(id: "1",
                                content: .init(id: "photo01")),
                     MemoryCard(id: "2",
                                content: .init(id: "photo01")),
                     MemoryCard(id: "3",
                                content: .init(id: "photo02")),
                     MemoryCard(id: "4",
                                content: .init(id: "photo02"))]
        cards.shuffle()

        self.gameController = MemoryCardGameController(cards: cards)
        self.cards = cards

        observeCardChanges()
    }

    func didTapCard(_ card: MemoryCard) {
        gameController.turnCardToReveal(card)
    }

    private func observeCardChanges() {
        gameController.cardsDidChange = { @MainActor [weak self] in
            guard let self else {
                return
            }

            self.cards = self.gameController.cards
        }
    }
}
