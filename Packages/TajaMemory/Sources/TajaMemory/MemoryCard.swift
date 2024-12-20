// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct MemoryCard: Equatable, Identifiable {

    public enum State {
        case concealed
        case revealed
    }

    public let id: String
    public var state: State

    let content: MemoryCardContent

    public init(id: String = UUID().uuidString,
                content: MemoryCardContent,
                state: State = .concealed) {
        self.id = id
        self.content = content
        self.state = state
    }

    public mutating func reveal() {
        state = .revealed
    }

    public mutating func conceal() {
        state = .concealed
    }
}
