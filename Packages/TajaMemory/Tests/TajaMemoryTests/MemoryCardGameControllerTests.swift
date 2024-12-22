//
//  MemoryCardGameControllerTests.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

import Testing

import TestingTags

@testable import TajaMemory

class MemoryCardGameController {

    private(set) var gameBoard: MemoryCardGameBoard

    init(gameBoard: MemoryCardGameBoard) {
        self.gameBoard = gameBoard
    }

    func didSelectCard(_ card: MemoryCard) {
        gameBoard.revealCard(card)
    }
}

@Suite(.tags(.acceptanceTest))
struct MemoryCardGameControllerTests {

    private let controller: MemoryCardGameController

    init() {
        self.controller = MemoryCardGameController(gameBoard: .fixture())
    }

    @Test
    func should_reveal_a_card_when_it_is_selected() async throws {
        let card = try #require(anyConcealedCard())

        selectCard(card)

        #expect(isCardRevealed(card))
    }

    // MARK: - Testing DSL

    private func anyConcealedCard() -> MemoryCard? {
        return controller.gameBoard.cards.first(where: { $0.state == .concealed })
    }

    private func selectCard(_ card: MemoryCard) {
        controller.didSelectCard(card)
    }

    private func isCardRevealed(_ card: MemoryCard) -> Bool {
        return controller.gameBoard.revealedCards.contains(where: { $0.id == card.id })
    }
}
