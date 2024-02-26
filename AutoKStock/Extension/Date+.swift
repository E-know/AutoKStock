//
//  Date+.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/20/24.
//

import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmmss"
        
        return dateFormatter.string(from: self)
    }
    
    static var krStockOpenDate: Date = {
        let currentDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
        let year = String(currentDateComponents.year!)
        let month = String(format: "%02d", currentDateComponents.month!)
        let day = String(format: "%02d", currentDateComponents.day!)
        let df = DateFormatter()
        df.dateFormat = "yyyyMMddHHmm"
        let date = df.date(from: year + month + day + "0900")!
        
        return date
    }()
    
    static var krStockCloseDate: Date = {
        let currentDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
        let year = String(currentDateComponents.year!)
        let month = String(format: "%02d", currentDateComponents.month!)
        let day = String(format: "%02d", currentDateComponents.day!)
        let df = DateFormatter()
        df.dateFormat = "yyyyMMddHHmm"
        let date = df.date(from: year + month + day + "1530")!
        
        return date
    }()
    
    var isSharpDate: Bool {
        let currentDateComponents = Calendar.current.dateComponents([.minute], from: self)
        
        if let minute = currentDateComponents.minute, minute == 0 {
            return true
        } else {
            return false
        }
    }
    
    var minute: String {
        let currentDateComponents = Calendar.current.dateComponents([.minute], from: self)
        return String(currentDateComponents.minute!)
    }
    
    var hour: String {
        let currentDateComponents = Calendar.current.dateComponents([.hour], from: self)
        return String(currentDateComponents.hour!)
    }
}


