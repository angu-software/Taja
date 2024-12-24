//
//  MemoryCardGameController.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 24.12.24.
//

final class MemoryCardGameController {

    var revealedCards: [MemoryCard] {
        return cards.filter({ $0.state == .revealed })
    }

    private(set) var cards: [MemoryCard]
    private(set) var resolvedPairs: [MemoryCardPair] = []

    private var firstCard: MemoryCard?

    init(cards: [MemoryCard]) {
        self.cards = cards
    }

    func didSelectCard(_ card: MemoryCard) {
        var card = card
        revealCard(&card)

        if var firstCard {
            let pair = MemoryCardPair(firstCard, card)
            if pair.isResolved {
                resolvedPairs.append(pair)
            } else {
                concealCard(&card)
                concealCard(&firstCard)
            }
            self.firstCard = nil
        } else {
            firstCard = card
        }
    }

    private func revealCard(_ card: inout MemoryCard) {
        guard let cardIndex = cards.firstIndex(of: card) else {
            return
        }

        card.reveal()
        cards[cardIndex] = card
    }

    private func concealCard(_ card: inout MemoryCard) {
        guard let cardIndex = cards.firstIndex(of: card) else {
            return
        }

        card.conceal()
        cards[cardIndex] = card
    }
}
