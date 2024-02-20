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
        df.dateFormat = "yyyyMMddHH"
        let date = df.date(from: year + month + day + "09")!
        
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
}


