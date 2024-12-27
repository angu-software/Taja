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

    static func makeMemoryCards() -> [MemoryCard] {
        return CardGenerator.makeMemoryCards()
            .map({ $0 })
            .shuffled()

    }

    @Published
    private(set) var cards: [MemoryCard] = []

    private var gameController: MemoryCardGameController

    init(cards: [MemoryCard] = makeMemoryCards()) {
        self.gameController = MemoryCardGameController(cards: cards)
        self.cards = cards

        observeCardChanges()
    }

    func startNewGame() {
        let cards = Self.makeMemoryCards()

        self.gameController = MemoryCardGameController(cards: cards)
        self.cards = cards

        observeCardChanges()
    }

    func didTapCard(_ card: MemoryCard) {
        gameController.turnCardToReveal(card)
    }

    func cardIndex(forRow row: Int, column: Int) -> Int {
        let columnCount = 3
        let offset = row * columnCount
        return offset + column
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
