//
//  MemoryCardPair.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 21.12.24.
//


struct MemoryCardPair {

    typealias State = MemoryCardGameLoop.EvaluationResult

    let one: MemoryCard
    let two: MemoryCard

    var state: State {
        return isResolved ? .pairIsMatching : .pairNotMatching
    }

    var isResolved: Bool {
        return isContainingDifferentCards && isContainingMatchingContent
    }

    private var isContainingDifferentCards: Bool {
        return one.id != two.id
    }

    private var isContainingMatchingContent: Bool {
        return one.content == two.content
    }

    init(_ one: MemoryCard, _ two: MemoryCard) {
        self.one = one
        self.two = two
    }
}
