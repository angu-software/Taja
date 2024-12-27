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

    public var cardsDidChange: (() -> Void)?
    public private(set) var cards: [MemoryCard] {
        didSet {
            if cards != oldValue {
                cardsDidChange?()
            }
        }
    }

    private(set) var resolvedPairs: [MemoryCardPair] = []

    private let gameLoop = MemoryCardGameLoop()
    private let lookingOnCardsDuration: TimeInterval

    private var firstCard: MemoryCard?
    private var secondCard: MemoryCard?
    private var isShowingCards = false

    private var selectedPair: MemoryCardPair? {
        guard let firstCard,
              let secondCard else {
            return nil
        }

        return MemoryCardPair(firstCard,
                              secondCard)
    }

    public init(cards: [MemoryCard], lookingOnCardsDuration: TimeInterval = 1) {
        self.cards = cards
        self.lookingOnCardsDuration = lookingOnCardsDuration

        observeGameLoop()
    }

    public func turnCardToReveal(_ card: MemoryCard) {
        memorizeConcealedCard(card)
        runGameLoop()
    }

    private func memorizeConcealedCard(_ card: MemoryCard) {
        guard let index = index(of: card),
              cards[index].state == .concealed else {
            return
        }

        if gameLoop.state == .selectFirstCard {
            firstCard = card
        } else if gameLoop.state == .selectSecondCard {
            secondCard = card
        }
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
        case .showCards where isShowingCards == false:
            advanceGame(after: lookingOnCardsDuration)
        case .showCards:
            break
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
        Task { @MainActor in
            isShowingCards = true
            try await Task.sleep(for: .seconds(duration))
            self.advanceGame()
            isShowingCards = false
        }
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
        firstCard = nil
        secondCard = nil
    }

    private func index(of card: MemoryCard) -> Int? {
        return cards.firstIndex(where: { $0.id == card.id })
    }
}
