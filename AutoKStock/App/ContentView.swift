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
        if let url = Bundle.main.url(forResource: "KOSPI", withExtension: "csv") {
            do {
                let csvString = try String(contentsOf: url)
                let csvLines = csvString.components(separatedBy: .newlines)
                for line in csvLines where line.count > 0 {
                    let fields = line.components(separatedBy: ",")
                    
                    let name = fields[0]
                    let key = String(format: "%06d", Int(fields[1])!)
                    
                    
                    // 이제 fields 배열에 각 줄의 필드가 들어있습니다.
                }
            } catch {
                print("Failed to read file: \(error)")
            }
        } else {
            print("File not found")
        }
    }
}

#Preview {
    ContentView()
}
