//
//  MemoryCardGameLoopTests.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 22.12.24.
//

import Testing

@testable import TajaMemory

struct MemoryCardGameLoopTests {

    @Test
    func should_start_with_selecting_first_card() {
        let loop = MemoryCardGameLoop()

        #expect(loop.state == .selectFirstCard)
    }

    @Test
    func should_advance_from_select_first_card_to_select_second_card() async throws {
        let loop = MemoryCardGameLoop()

        loop.advance()

        #expect(loop.state == .selectSecondCard)
    }

    @Test
    func should_advance_from_select_second_card_to_evaluate_selected_pair() async throws {
        let loop = MemoryCardGameLoop(state: .selectSecondCard)

        loop.advance()

        #expect(loop.state == .evaluateSelectedPair)
    }

    @Test
    func should_advance_from_evaluate_selected_pair_to_resolve_pair_when_pair_is_match() async throws {
        let loop = MemoryCardGameLoop(state: .evaluateSelectedPair)

        loop.advance(.pairIsMatching)

        #expect(loop.state == .resolvePair)
    }

    @Test
    func should_advance_from_evaluate_selected_pair_to_conceal_pair_when_pair_not_matching() async throws {
        let loop = MemoryCardGameLoop(state: .evaluateSelectedPair)

        loop.advance(.pairNotMatching)

        #expect(loop.state == .concealPair)
    }

    @Test
    func should_advance_from_resolvePair_pair_to_select_first_card() async throws {
        let loop = MemoryCardGameLoop(state: .resolvePair)

        loop.advance()

        #expect(loop.state == .selectFirstCard)
    }

    @Test
    func should_advance_from_conceal_pair_to_select_first_card() async throws {
        let loop = MemoryCardGameLoop(state: .concealPair)

        loop.advance()

        #expect(loop.state == .selectFirstCard)
    }

    @Test
    func should_notify_when_state_changed() async throws {
        let loop = MemoryCardGameLoop(state: .concealPair)
        var stateChanged: Bool?
        loop.stateDidChange = {
            stateChanged = true
        }

        loop.advance()

        #expect(stateChanged == true)
    }
}
