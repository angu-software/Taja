//
//  MemoryCardContent.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 20.12.24.
//

import Foundation

public struct MemoryCardContent: Equatable, Identifiable {

    public let id: String

    public init(id: String) {
        self.id = id
    }
}
