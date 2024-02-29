//
//  ContentView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import AppKit
import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("종료") {
                NSApp.terminate(nil)
            }
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
