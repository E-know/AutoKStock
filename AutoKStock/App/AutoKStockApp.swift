//
//  AutoKStockApp.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import AppKit
import SwiftUI

@main
struct AutoKStockApp: App {
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    
    var body: some Scene {
        WindowGroup {
            FirstSettingView()
        }
        .onChange(of: scenePhase) { oldPhase, phase in
            print(oldPhase, phase)
            switch phase {
            case .active:
                print("HELLO")
            case .inactive:
                print("GOOD")
            case .background:
                print("HIHI")
            @unknown default:
                print("GOOD12")
            }
        }
    }
}
