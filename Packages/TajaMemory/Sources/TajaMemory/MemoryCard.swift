// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct MemoryCard: Equatable {

    public enum State {
        case concealed
        case revealed
    }

    public var state: State

    let content: MemoryCardContent

    public init(content: MemoryCardContent,
                state: State = .concealed) {
        self.content = content
        self.state = state
    }

    public mutating func reveal() {
        state = state == .concealed ? .revealed : .concealed
    }

    public mutating func conceal() {
        state = .concealed
    }
}
