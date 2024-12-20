// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UIKit

public struct MemoryCardView: View {

    private let frontImage: UIImage
    private let backImage:UIImage

    public init(frontImage: UIImage,
                backImage: UIImage) {
        self.frontImage = frontImage
        self.backImage = backImage
    }

    // MARK: - SwiftUI-View

    public var body: some View {
        Image(uiImage: backImage)
            .resizable()
            .frame(width: 200, height: 200)
            .border(.black,
                    width: 1)
    }
}
