//
//  MemoryCardGameBoard.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

struct MemoryCardGameBoard {

    let contents: [MemoryCardContent]

    var cards: [MemoryCard]

    init(contents: [MemoryCardContent]) {
        self.contents = contents
        self.cards = Self.makeCards(contents: contents)
    }

    static func makeCards(contents: [MemoryCardContent]) -> [MemoryCard] {
        return [MemoryCard(),
                MemoryCard()]
    }
}
