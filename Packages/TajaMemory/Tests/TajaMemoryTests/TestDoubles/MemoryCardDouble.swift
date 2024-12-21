//
//  MemoryCardDouble.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 21.12.24.
//

import Foundation

@testable import TajaMemory

extension MemoryCard {

    static func fixture(id: String = UUID().uuidString,
                        content: MemoryCardContent,
                        state: MemoryCard.State = .concealed) -> Self {
        self.init(id: id,
                  content: content,
                  state: state)
    }
}
