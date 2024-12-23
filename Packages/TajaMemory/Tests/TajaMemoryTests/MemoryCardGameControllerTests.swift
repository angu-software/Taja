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
    private(set) var resolvedPairs: [MemoryCardPair] = []

    private var firstCard: MemoryCard?

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

        var card = card
        card.reveal()
        if let firstCard {
            let pair = MemoryCardPair(firstCard, card)
            if pair.isResolved {
                resolvedPairs.append(pair)
            }
        } else {
            firstCard = card
        }
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
 * If second card is first card (revealed) do nothing

 * ACCs
 * ~~New game -> all cards are concealed~~
 * ~~Select one card -> reveal~~
 * ~~When second revealed card match first card -> resolved~~
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
    func should_reveal_first_selected_card() async throws {
        startNewGame()

        let selectedCard = try #require(choseCard())
        turnCard(selectedCard)

        #expect(numberOfRevealedCards() == 1)
        #expect(isCardRevealed(selectedCard))
    }

    @Test func should_resolve_as_pair_of_cards_when_second_selected_card_matches_first_card() async throws {
        startNewGame()
        let firstCard = try #require(choseCard())
        turnCard(firstCard)

        let secondCard = try #require(choseCard(matching: firstCard))
        turnCard(secondCard)

        #expect(isResolvedPair(firstCard, secondCard))
    }

    // MARK: - Testing DSL

    private func startNewGame() {
        controller.startNewGame()
    }

    private func choseCard(matching matchingCard: MemoryCard? = nil) -> MemoryCard? {
        if let matchingCard {
            return controller.gameBoard.cards.first(where: {
                return $0.state == .concealed && $0.content == matchingCard.content
            })
        }

        return controller.gameBoard.cards.first(where: { $0.state == .concealed })
    }

    private func turnCard(_ card: MemoryCard) {
        controller.didSelectCard(card)
    }

    private func allCardsConcealed() -> Bool {
        return controller.cards.allSatisfy({ $0.state == .concealed })
    }

    private func numberOfRevealedCards() -> Int {
        return controller.gameBoard.revealedCards.count
    }

    private func isCardRevealed(_ card: MemoryCard) -> Bool {
        return controller.gameBoard.revealedCards.contains(where: { $0.id == card.id })
    }

    private func isResolvedPair(_ first: MemoryCard, _ second: MemoryCard) -> Bool {
        return controller.resolvedPairs.contains { pair in
            return pair.one.id == first.id &&
            pair.two.id == second.id
        }
    }
}
