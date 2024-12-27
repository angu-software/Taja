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

        startApp()
    }

    func test_should_reveal_a_card_when_tapped() throws {
        let card = choseConcealedCard()
        let cardId = card.identifier

        tapCard(card)

        XCTAssert(isCardRevealed(cardId))
    }

    func test_should_conceal_selected_cards_when_not_matching() async throws {
        let firstCard = chooseCard("memoryCard_1_concealed_photo01")
        let secondCard = chooseCard("memoryCard_3_concealed_photo02")
        let firstCardId = firstCard.identifier
        let secondCardId = secondCard.identifier

        tapCard(firstCard)
        tapCard(secondCard)

        try await lookAtCards()

        XCTAssert(isCardConcealed(firstCardId))
        XCTAssert(isCardConcealed(secondCardId))
    }

    func test_should_start_new_game() {
        let firstCard = chooseCard("memoryCard_1_concealed_photo01")
        tapCard(firstCard)

        startNewGame()

        // all cards concealed
        XCTAssert(isCardConcealed("memoryCard_1_concealed_photo01"))
    }

    private func startApp() {
        app.launch()
        _ = app.wait(for: .runningForeground,
                     timeout: 0.3)
    }

    private func startNewGame() {
        let startNewGameButton = app.buttons["Neues Spiel"]
        startNewGameButton.tap()
    }

    private func choseConcealedCard() -> XCUIElement {
        return chooseCard("memoryCard_1_concealed_photo01")
    }

    private func chooseCard(_ id: String) -> XCUIElement {
        return app.images[id]
    }

    private func tapCard(_ card: XCUIElement) {
        card.tap()
    }

    private func lookAtCards() async throws {
        try await Task.sleep(for: .seconds(1.1))
    }

    private func isCardRevealed(_ cardId: String) -> Bool {
        var cardId = cardId
        cardId = cardId.replacingOccurrences(of: "_concealed", with: "_revealed")
        return app.images[cardId].exists
    }

    private func isCardConcealed(_ cardId: String) -> Bool {
        var cardId = cardId
        cardId = cardId.replacingOccurrences(of: "_revealed", with: "_concealed")
        return app.images[cardId].exists
    }
}
