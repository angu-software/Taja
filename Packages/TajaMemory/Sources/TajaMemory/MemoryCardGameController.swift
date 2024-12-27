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
    private var firstCard: MemoryCard?
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
    }

    public func didSelectCard(_ card: MemoryCard) {
        var card = card
        revealCard(&card)

        selectedCards.append(card)

        if let selectedPair = selectedPair {
            if selectedPair.isResolved {
                resolvedPairs.append(selectedPair)
            } else {
                concealPair(selectedPair)
            }
            self.selectedCards = []
        }
    }

    private func revealCard(_ card: inout MemoryCard) {
        guard let cardIndex = cards.firstIndex(of: card) else {
            return
        }

        card.reveal()
        cards[cardIndex] = card
    }

    private func concealPair(_ selectedPair: MemoryCardPair) {
        concealCard(selectedPair.one)
        concealCard(selectedPair.two)
    }

    private func concealCard(_ card: MemoryCard) {
        guard let cardIndex = cards.firstIndex(of: card) else {
            return
        }

        cards[cardIndex].conceal()
    }
}
