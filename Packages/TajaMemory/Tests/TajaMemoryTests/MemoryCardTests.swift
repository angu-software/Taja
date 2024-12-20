//
//  MemoryCardTests.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

import Testing

@testable import TajaMemory

@Suite
struct MemoryCardTests {

    private func makeMemoryCard() -> MemoryCard {
        return MemoryCard(content: .init())
    }

    @Test
    func should_be_concealed_initially() async throws {
        #expect(MemoryCard(content: .init()).state == .concealed)
    }

    @Test
    func should_be_revealed_when_revealing() async throws {
        var memoryCard = makeMemoryCard()

        memoryCard.reveal()

        #expect(memoryCard.state == .revealed)
    }

    @Test
    func should_be_concealed_when_concealing() async throws {
        var memoryCard = makeMemoryCard()
        memoryCard.reveal()

        memoryCard.conceal()

        #expect(memoryCard.state == .concealed)
    }
}
