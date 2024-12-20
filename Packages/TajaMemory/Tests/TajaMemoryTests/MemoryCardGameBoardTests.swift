//
//  MemoryCardGameTests.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

import Testing

@testable import TajaMemory

@Suite
struct MemoryCardGameBoardTests {

    @Test
    func should_generate_two_matching_cards_for_each_photo() async throws {
        let cardContent1 = MemoryCardContent.fixture(id: "1")
        let cardContent2 = MemoryCardContent.fixture(id: "2")
        let gameBoard = MemoryCardGameBoard(contents: [cardContent1,
                                                       cardContent2])

        #expect(gameBoard.cards.count(where: { $0.content == cardContent1 }) == 2)
        #expect(gameBoard.cards.count(where: { $0.content == cardContent2 }) == 2)
    }
}
