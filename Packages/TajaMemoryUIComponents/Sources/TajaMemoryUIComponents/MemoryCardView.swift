// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UIKit

import TajaMemory

public struct MemoryCardView: View {

    public typealias State = MemoryCard

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

    // MARK: - SwiftUI-View

    public var body: some View {
        Image(uiImage: shownImage)
            .resizable()
            .frame(width: 200, height: 200)
            .border(.black,
                    width: 1)
    }
}