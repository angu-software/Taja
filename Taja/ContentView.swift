//
//  ContentView.swift
//  Taja
//
//  Created by Andreas Guenther on 20.12.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GridLayout(alignment: .center, horizontalSpacing: 4, verticalSpacing: 4) {
            GridRow(alignment: .center) {
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 200, height: 200)
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 200, height: 200)
            }
            GridRow(alignment: .center) {
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 200, height: 200)
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 200, height: 200)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
