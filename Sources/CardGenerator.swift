//
//  CardGenerator.swift
//  Taja
//
//  Created by Andreas Guenther on 27.12.24.
//

import TajaMemory

final class CardGenerator {

    static func makeMemoryCards() -> [MemoryCard] {
        var contentId = 1
        var cards: [MemoryCard] = []
        for cardId in (1...18) {
            cards.append(MemoryCard(id: "\(cardId)",
                              content: .init(id: "photo0\(contentId)")))

            if cardId % 2 == 0 {
                contentId += 1
            }
        }

        cards.shuffle()

        return cards
    }
}
