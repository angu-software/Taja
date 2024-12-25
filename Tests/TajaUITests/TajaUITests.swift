//
//  TajaUITests.swift
//  TajaUITests
//
//  Created by Andreas Guenther on 20.12.24.
//

import XCTest

import TajaMemoryUIComponents

@MainActor
final class TajaMemoryUITests: XCTestCase {

    private let app = XCUIApplication()

    override func setUp() async throws {
        try await super.setUp()

        startNewGame()
    }

    func test_should_reveal_a_card_when_tapped() throws {
        let card = try XCTUnwrap(choseConcealedCard())

        tapCard(card)

        XCTAssert(isCardRevealed(card))
    }

    private func startNewGame() {
        app.launch()
        _ = app.wait(for: .runningForeground,
                     timeout: 0.3)
    }

    private func choseConcealedCard() -> XCUIElement? {
        let concealedCardPredicate = NSPredicate(format: "identifier MATCHES %@", "^memoryCard_.*_concealed$")

        return app.images.matching(concealedCardPredicate).firstMatch
    }

    private func tapCard(_ card: XCUIElement) {
        card.tap()
    }

    private func isCardRevealed(_ card: XCUIElement) -> Bool {
        var cardId = card.identifier
        cardId = cardId.replacingOccurrences(of: "_concealed", with: "_revealed")
        return app.images[cardId].exists
    }
}
