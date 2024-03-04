//
//  StockInfoManager.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/19/24.
//

import Foundation

class StockInfoManager {
    private var numToName = [String: String]()
    private var nameToNum = NTree()
    private init() {
        readCSV(name: "KOSPI")
        readCSV(name: "KOSDAQ")
    }
    
    static let shared = StockInfoManager()
    
    private func readCSV(name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "csv") {
            do {
                let csvString = try String(contentsOf: url)
                let csvLines = csvString.components(separatedBy: .newlines)
                for line in csvLines where line.count > 0 {
                    let fields = line.components(separatedBy: ",")
                    
                    let name = fields[0]
                    let key = String(format: "%06d", Int(fields[1])!)
                    
                    numToName[key] = name
                    nameToNum.append(name, productCode: key)
                }
            } catch {
                print("Failed to read \(name) file: \(error)")
            }
        } else {
            print("\(name) File not found")
        }
    }
    
    func getStockFromCode(productCode: String) throws -> [StockInfo] {
        guard let num = Int(productCode) else { throw SearchError.codeIsNotNumber }
        let productCode = String(format: "%06d", num)
        guard let name = numToName[productCode] else { throw SearchError.notExist }
        return [StockInfo(productCode: productCode, name: name)]
    }
    
    func getStockFromName(name: String) throws -> [StockInfo] {
        let stockInfo = nameToNum.find(name: name)
        guard !stockInfo.isEmpty else { throw SearchError.notExist }
        return stockInfo
    }
}

enum SearchError: LocalizedError {
    case codeIsNotNumber
    case notExist
    
    public var errorDescription: String? {
        switch self {
        case .codeIsNotNumber: "ProductCode가 숫자가 아닙니다."
        case .notExist: "해당 정보가 존재하지 않습니다."
        }
    }
}
