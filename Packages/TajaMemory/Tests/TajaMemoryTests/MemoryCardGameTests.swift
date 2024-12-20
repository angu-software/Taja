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
        let gameBoard = MemoryCardGameBoard(contents: [MemoryCardContent()])

        #expect(gameBoard.cards.count == 2)
    }
}
