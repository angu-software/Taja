//
//  MemoryCardGameBoard.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

struct MemoryCardGameBoard {

    let contents: [MemoryCardContent]

    var cards: [MemoryCard]

    var revealedCards: [MemoryCard] {
        return cards.filter({ $0.state == .revealed })
    }

    init(contents: [MemoryCardContent]) {
        self.contents = contents
        self.cards = Self.makeCards(contents: contents)
    }

    static func makeCards(contents: [MemoryCardContent]) -> [MemoryCard] {
        return contents.reduce(into: [MemoryCard]()) { partialResult, content in
            partialResult += [MemoryCard(content: content),
                              MemoryCard(content: content)]
        }
    }
}
