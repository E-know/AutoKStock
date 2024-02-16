//
//  ContentView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            test()
        }
    }
    
    private func test() {
    }
}

#Preview {
    ContentView()
}
