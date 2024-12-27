//
//  MemoryCardGameController.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 24.12.24.
//

import Foundation

@MainActor
public final class MemoryCardGameController {

    var revealedCards: [MemoryCard] {
        return cards.filter({ $0.state == .revealed })
    }

    public private(set) var cards: [MemoryCard]
    private(set) var resolvedPairs: [MemoryCardPair] = []

    private let gameLoop = MemoryCardGameLoop()
    private var selectedCards: [MemoryCard] = []

    private var firstCard: MemoryCard? {
        return selectedCards.first
    }

    private var secondCard: MemoryCard? {
        guard selectedCards.indices.contains(1) else {
            return nil
        }

        return selectedCards[1]
    }

    private var selectedPair: MemoryCardPair? {
        guard selectedCards.indices.contains(0),
              selectedCards.indices.contains(1) else {
            return nil
        }

        return MemoryCardPair(selectedCards[0],
                              selectedCards[1])
    }

    public init(cards: [MemoryCard]) {
        self.cards = cards

        observeGameLoop()
    }

    public func didSelectCard(_ card: MemoryCard) {
        selectedCards.append(card)
        runGameLoop()
    }

    private func observeGameLoop() {
        gameLoop.stateDidChange = { [weak self] in
            self?.runGameLoop()
        }
    }

    private func runGameLoop() {
        switch self.gameLoop.state {
        case .selectFirstCard:
            revealCard(firstCard)
        case .selectSecondCard:
            revealCard(secondCard)
        case .showCards:
            advanceGame(after: 1)
        case .evaluateSelectedPair:
            evaluate(selectedPair)
        case .resolvePair:
            resolvePair(selectedPair)
        case .concealPair:
            concealPair(selectedPair)
        }
    }

    private func revealCard(_ card: MemoryCard?) {
        guard let card,
              let cardIndex = index(of: card) else {
            return
        }

        cards[cardIndex].reveal()
        advanceGame()
    }

    private func evaluate(_ selectedPair: MemoryCardPair?) {
        guard let selectedPair else {
            return
        }

        advanceGame(selectedPair.state)
    }

    private func advanceGame(after duration: TimeInterval) {
        advanceGame()
    }

    private func advanceGame(_ evaluationResult: MemoryCardGameLoop.EvaluationResult? = nil) {
        gameLoop.advance(evaluationResult)
    }
    
    private func resolvePair(_ selectedPair: MemoryCardPair?) {
        guard let selectedPair else {
            return
        }

        resolvedPairs.append(selectedPair)
        restSelectedCards()
        advanceGame()
    }

    private func concealPair(_ selectedPair: MemoryCardPair?) {
        guard let selectedPair else {
            return
        }

        concealCard(selectedPair.one)
        concealCard(selectedPair.two)

        restSelectedCards()
        advanceGame()
    }

    private func concealCard(_ card: MemoryCard) {
        guard let cardIndex = index(of: card) else {
            return
        }

        cards[cardIndex].conceal()
    }

    private func restSelectedCards() {
        selectedCards = []
    }

    private func index(of card: MemoryCard) -> Int? {
        return cards.firstIndex(where: { $0.id == card.id })
    }
}
