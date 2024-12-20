// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct MemoryCard {

    public enum State {
        case concealed
        case revealed
    }

    public var state: State

    public init(state: State = .concealed) {
        self.state = state
    }

    public mutating func reveal() {
        state = state == .concealed ? .revealed : .concealed
    }

    public mutating func conceal() {
        state = .concealed
    }
}
