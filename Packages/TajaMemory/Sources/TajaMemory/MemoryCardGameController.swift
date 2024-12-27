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

        gameLoop.stateDidChange = { [weak self] in
            guard let self else {
                return
            }

            switch self.gameLoop.state {
            case .selectFirstCard,
                .selectSecondCard:
                break
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
                    resolvedPairs.append(selectedPair)
                    gameLoop.advance()
                }
                self.selectedCards = []
            case .concealPair:
                if let selectedPair = self.selectedPair {
                    concealPair(selectedPair)
                    gameLoop.advance()
                }
                self.selectedCards = []
            }
        }
    }

    public func didSelectCard(_ card: MemoryCard) {
        switch gameLoop.state {
        case .selectFirstCard,
             .selectSecondCard:

            revealCard(card)

            selectedCards.append(card)

            gameLoop.advance()
        default:
            break
        }
    }

    private func revealCard(_ card: MemoryCard) {
        guard let cardIndex = index(of: card) else {
            return
        }

        cards[cardIndex].reveal()
    }

    private func concealPair(_ selectedPair: MemoryCardPair) {
        concealCard(selectedPair.one)
        concealCard(selectedPair.two)
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
