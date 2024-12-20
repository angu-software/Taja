// The Swift Programming Language
// https://docs.swift.org/swift-book

struct MemoryCard {

    enum State {
        case concealed
        case revealed
    }

    var state: State = .concealed

    mutating func reveal() {
        state = state == .concealed ? .revealed : .concealed
    }

    mutating func conceal() {
        state = .concealed
    }
}
