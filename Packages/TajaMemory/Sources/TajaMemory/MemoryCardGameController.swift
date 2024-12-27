//
//  MemoryCardGameController.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 24.12.24.
//

public final class MemoryCardGameController {

    var revealedCards: [MemoryCard] {
        return cards.filter({ $0.state == .revealed })
    }

    public private(set) var cards: [MemoryCard]
    private(set) var resolvedPairs: [MemoryCardPair] = []

    private let gameLoop = MemoryCardGameLoop()
    private var selectedCards: [MemoryCard] = []

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
            if let card = selectedCards.first {
                revealCard(card)

                gameLoop.advance()
            }
        case .selectSecondCard:
            if selectedCards.indices.contains(1) {
                let card = selectedCards[1]
                revealCard(card)

                gameLoop.advance()
            }
        case .evaluateSelectedPair:
            if let selectedPair = self.selectedPair {
                if selectedPair.isResolved {
                    gameLoop.advance(.pairIsMatching)
                } else {
                    gameLoop.advance(.pairNotMatching)
                }
            }
        case .resolvePair:
            if let selectedPair = self.selectedPair {
                resolvePair(selectedPair)
                gameLoop.advance()
            }
        case .concealPair:
            if let selectedPair = self.selectedPair {
                concealPair(selectedPair)
                gameLoop.advance()
            }
        }
    }

    private func revealCard(_ card: MemoryCard) {
        guard let cardIndex = index(of: card) else {
            return
        }

        cards[cardIndex].reveal()
    }

    private func restSelectedCards() {
        selectedCards = []
    }

    private func resolvePair(_ selectedPair: MemoryCardPair) {
        resolvedPairs.append(selectedPair)
        restSelectedCards()
    }

    private func concealPair(_ selectedPair: MemoryCardPair) {
        concealCard(selectedPair.one)
        concealCard(selectedPair.two)

        restSelectedCards()
    }

    private func concealCard(_ card: MemoryCard) {
        guard let cardIndex = index(of: card) else {
            return
        }

        cards[cardIndex].conceal()
    }

    private func index(of card: MemoryCard) -> Int? {
        return cards.firstIndex(where: { $0.id == card.id })
    }
}
