//
//  MemoryCardGameLoop.swift
//  TajaMemory
//
//  Created by Andreas Guenther on 22.12.24.
//

final class MemoryCardGameLoop {

    enum State {
        case selectFirstCard
        case selectSecondCard
        case evaluateSelectedPair
        case resolvePair
        case concealPair
    }

    enum EvaluationResult {
        case pairIsMatching
        case pairNotMatching
    }

    private(set) var state: State = .selectFirstCard {
        didSet {
            stateDidChange?()
        }
    }

    var stateDidChange: (() -> Void)?

    init(state: State = .selectFirstCard) {
        self.state = state
    }

    func advance(_ evaluationResult: EvaluationResult? = nil) {
        switch state {
        case .selectFirstCard:
            state = .selectSecondCard
        case .selectSecondCard:
            state = .evaluateSelectedPair
        case .evaluateSelectedPair where evaluationResult == .pairIsMatching:
            state = .resolvePair
        case .evaluateSelectedPair:
            state = .concealPair
        case .resolvePair,
             .concealPair:
            state = .selectFirstCard
        }
    }
}
