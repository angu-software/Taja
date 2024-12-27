//
//  MemoryCardGameControllerTests.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

import Testing

import TestingTags

@testable import TajaMemory

/* =======
 * Work log
 * =======
 *
 * No selection when game loop past selecting states
 * Selecting revealed card -> does nothing [If second card is first card (revealed) do nothing]
 * Next game has different card order

 * ACCs
 * When all cards revealed -> game ends
 */

@MainActor
@Suite
final class MemoryCardGameControllerTests {

    private var controller: MemoryCardGameController!

    init() {
        startNewGame()
    }

    @Test(.tags(.acceptanceTest))
    func should_begin_new_game_with_all_cards_concealed() async throws {
        #expect(allCardsConcealed())
    }

    @Test(.tags(.acceptanceTest))
    func should_reveal_first_selected_card() async throws {
        let selectedCard = try #require(choseConcealedCard())
        turnCard(selectedCard)

        #expect(numberOfRevealedCards() == 1)
        #expect(isCardRevealed(selectedCard))
    }

    @Test(.tags(.acceptanceTest))
    func should_resolve_selected_pair_of_cards_when_second_selected_card_matches_first_card() async throws {
        let firstCard = try #require(choseConcealedCard())
        turnCard(firstCard)

        let secondCard = try #require(choseConcealedCard(.matching(firstCard)))
        turnCard(secondCard)

        try await lookAtCards()

        #expect(isResolvedPair(firstCard, secondCard))
    }

    @Test(.tags(.acceptanceTest))
    func should_reset_selected_pair_of_cards_when_second_selected_card__does_not_match_first_card() async throws {
        let firstCard = try #require(choseConcealedCard())
        turnCard(firstCard)

        let secondCard = try #require(choseConcealedCard(.notMatching(firstCard)))
        turnCard(secondCard)

        try await lookAtCards()

        #expect(!isResolvedPair(firstCard, secondCard))
        #expect(!isCardRevealed(firstCard))
        #expect(!isCardRevealed(secondCard))
    }

    @Test
    func should_not_conceal_revealed_card_when_selected_again() async throws {
        let firstCard = try #require(choseConcealedCard())
        turnCard(firstCard)

        turnCard(firstCard)

        try await lookAtCards()

        #expect(isCardRevealed(firstCard))
    }

    // MARK: - Testing DSL

    enum CardMatcher {
        case any
        case matching(MemoryCard)
        case notMatching(MemoryCard)
    }

    private func startNewGame() {
        self.controller = MemoryCardGameController(cards: MemoryCardGameBoard.fixture().cards,
                                                   lookingOnCardsDuration: 0.0)
    }

    private func choseConcealedCard(_ match: CardMatcher = .any) -> MemoryCard? {
        switch match {
        case .any:
            return controller.cards.first(where: { $0.state == .concealed })
        case let .matching(memoryCard):
            return controller.cards.first(where: {
                return $0.state == .concealed && $0.content == memoryCard.content
            })
        case let .notMatching(memoryCard):
            return controller.cards.first(where: {
                return $0.state == .concealed && $0.content != memoryCard.content
            })
        }
    }

    private func turnCard(_ card: MemoryCard) {
        controller.turnCardToReveal(card)
    }

    private func lookAtCards() async throws {
        try await Task.sleep(for: .milliseconds(1))
    }

    private func allCardsConcealed() -> Bool {
        return controller.cards.allSatisfy({ $0.state == .concealed })
    }

    private func numberOfRevealedCards() -> Int {
        return controller.revealedCards.count
    }

    private func isCardRevealed(_ card: MemoryCard) -> Bool {
        return controller.revealedCards.contains(where: { $0.id == card.id })
    }

    private func isResolvedPair(_ first: MemoryCard, _ second: MemoryCard) -> Bool {
        return controller.resolvedPairs.contains { pair in
            return pair.one.id == first.id &&
            pair.two.id == second.id
        }
    }
}
