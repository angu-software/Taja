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

    var cards: [MemoryCard] {
        return gameBoard.cards
    }

    init(gameBoard: MemoryCardGameBoard) {
        self.gameBoard = gameBoard
    }

    func startNewGame() {

    }

    func didSelectCard(_ card: MemoryCard) {
        gameBoard.revealCard(card)
    }
}

/* =======
 * Work log
 * =======
 *
 * No selection when game loop past selecting states
 * Select concealed card -> card revealed
 * Selecting revealed card -> does nothing
 * Next game has different card order

 * ACCs
 * New game -> all cards are concealed
 * Select one card -> reveal
 * When second revealed card match first card -> resolved
 * When second revealed card does not match first card -> conceal two cards
 * When all cards revealed -> game ends
 */

@Suite
struct MemoryCardGameControllerTests {

    private let gameLoop: MemoryCardGameLoop
    private let controller: MemoryCardGameController

    init() {
        self.gameLoop = MemoryCardGameLoop()
        self.controller = MemoryCardGameController(gameBoard: .fixture())
    }

    @Test(.tags(.acceptanceTest))
    func should_begin_new_game_with_all_cards_concealed() async throws {
        startNewGame()

        #expect(allCardsConcealed())
    }

    @Test(.tags(.acceptanceTest))
    func should_begin_new_game_with_all_cards_concealed() async throws {
        startNewGame()

        #expect(allCardsConcealed())
    }

    @Test
    func should_reveal_a_card_when_it_is_selected() async throws {
        let card = try #require(anyConcealedCard())

        selectCard(card)

        #expect(isCardRevealed(card))
    }

    // MARK: - Testing DSL

    private func startNewGame() {
        controller.startNewGame()
    }

    private func allCardsConcealed() -> Bool {
        return controller.cards.allSatisfy({ $0.state == .concealed })
    }

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
