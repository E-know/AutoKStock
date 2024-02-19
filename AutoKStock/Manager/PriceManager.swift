//
//  PriceManager.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/19/24.
//

import Foundation

class PriceManager {
    private init() {}
    static let shared = PriceManager()
    
    func getCurrentPrice(productNumber: String) async throws -> CurrentStockPriceData {
        let response: CurrentStockPriceData = try await NetworkManager()
            .method(method: .GET)
            .path(URLType.PriceURL(.current))
            .addHeader(field: "content-type", value: "application/json; charset=utf-8")
            .addHeader(field: "authorization", value: Configuration.shared.accessToken)
            .addHeader(field: "appkey", value: Configuration.shared.AppKey)
            .addHeader(field: "appsecret", value: Configuration.shared.AppSecret)
            .addHeader(field: "tr_id", value: "FHKST01010100")
            .addQuery(name: "FID_COND_MRKT_DIV_CODE", value: "J")
            .addQuery(name: "FID_INPUT_ISCD", value: productNumber)
            .decode()
        
        return response
    }
    
    func getStockInfo(productNumber: String) async throws -> StockInfoData {
        guard !Configuration.shared.ismockEnvironment else { throw EnvError.notSupportMockEnv }
        let response: StockInfoData = try await NetworkManager()
            .method(method: .GET)
            .path(URLType.PriceURL(.info))
            
    }
}
