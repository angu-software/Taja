//
//  MemoryCardPairTests.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

import Testing

@testable import TajaMemory

/* =======
 * Work log
 * =======
 *
 * - [ ] one,two == two,one
 */

struct MemoryCardPairTests {

    @Test
    func should_be_resolved_when_matching_cards_are_revealed() async throws {
        let card1 = MemoryCard.fixture(content: .fixture(id: "1"))
        let card2 = MemoryCard.fixture(content: .fixture(id: "1"))

        #expect(MemoryCardPair(card1, card2).isResolved)
    }

    @Test
    func should_not_be_resolved_when_pair_of_same_card() async throws {
        let card = MemoryCard.fixture(content: .fixture(id: "1"))

        #expect(!MemoryCardPair(card, card).isResolved)
    }
}
