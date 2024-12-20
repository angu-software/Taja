//
//  MemoryCardContent.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

import Foundation

public struct MemoryCardContent: Equatable {

    let matchingId: String

    init(matchingId: String) {
        self.matchingId = matchingId
    }
}
