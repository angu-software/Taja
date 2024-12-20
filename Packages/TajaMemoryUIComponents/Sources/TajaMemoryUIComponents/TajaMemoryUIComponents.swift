// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct MemoryCardView: View {

    public init() { }

    // MARK: - SwiftUI-View

    public var body: some View {
        Rectangle()
            .fill(Color.orange)
            .frame(width: 200, height: 200)
    }
}
