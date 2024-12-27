// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UIKit

import TajaMemory

public struct MemoryCardView: View {

    public typealias State = MemoryCard

    private let size: CGFloat = 144
    private let frontImage: UIImage
    private let backImage:UIImage
    private let state: State

    private var shownImage: UIImage {
        if state.state == .concealed {
            return backImage
        } else {
            return frontImage
        }
    }

    public init(frontImage: UIImage,
                backImage: UIImage,
                state: State) {
        self.frontImage = frontImage
        self.backImage = backImage
        self.state = state
    }

    private func makeA11yId() -> String {
        return "memoryCard_\(state.id)_\(state.state)_\(state.content.id)"
    }

    // MARK: - SwiftUI-View

    public var body: some View {
        Image(uiImage: shownImage)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipped()
            .background(.white)
            .border(.black,
                    width: 1)
            .accessibilityIdentifier(makeA11yId())
    }
}
