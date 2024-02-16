//
//  AppDelegate.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("HI")
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        
        if let token = Configuration.shared.accessToken {
            print(token)
        }
            
        print("안전하게 종료되었습니다.")
    }
}
