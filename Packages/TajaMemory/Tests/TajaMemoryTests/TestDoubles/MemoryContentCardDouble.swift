//
//  MemoryContentCardDouble.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

@testable import TajaMemory

extension MemoryCardContent {

    static var dummy: Self {
        return .fixture(id: "dummy")
    }

    static func fixture(id: String) -> Self {
        self.init(id: id)
    }
}
