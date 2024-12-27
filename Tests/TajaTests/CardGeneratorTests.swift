//
//  CardGeneratorTests.swift
//  TajaTests
//
//  Created by Andreas Guenther on 27.12.24.
//

import Testing

import TestingTags

@testable import Taja

@MainActor
struct CardGeneratorTests {

    private let expectedNumberOfCards = 18

    @Test(.tags(.acceptanceTest))
    func should_return_18_cards() async throws {
        #expect(CardGenerator.makeMemoryCards().count == expectedNumberOfCards)
    }

    @Test
    func should_generate_cards_with_ascending_ids() {
        let cardIds = CardGenerator.makeMemoryCards().map { $0.id }

        for expectedId in (1...expectedNumberOfCards).map({ "\($0)"}) {
            #expect(cardIds.contains(expectedId))
        }
    }

    @Test
    func should_contain_two_cards_for_each_photo() async throws {
        let expectedContentIds = PhotoAsset.allCases.prefix(9).map { $0.photoName }

        let cardContentIds = CardGenerator.makeMemoryCards().map { $0.content.id }

        for expectedId in expectedContentIds {
            #expect(cardContentIds.count(where: { $0 == expectedId }) == 2,
                    "To less cards for \(expectedId)")
        }
    }
}
