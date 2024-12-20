//
//  MemoryCardGameBoardDouble.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

@testable import TajaMemory

extension MemoryCardGameBoard {

    static func fixture(contents: [MemoryCardContent] = [.fixture(id: "1"),
                                                         .fixture(id: "2")]) -> Self {
        MemoryCardGameBoard(contents: contents)
    }
}
