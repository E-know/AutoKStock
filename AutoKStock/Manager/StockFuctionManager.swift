//
//  StockFuctionManager.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/18/24.
//

import Foundation
//
//enum StockFuctionError: Error, LocalizedError {
//    case notSupportMockEnv
//    
//    
//    public var errorDescription: String? {
//        switch self {
//        case.notSupportMockEnv: "모의투자환경에서는 지원하지 않습니다."
//        }
//    }
//}
//
//class StockFuctionManager {
//    private init() { }
//    static let shared = StockFuctionManager()
//    
//    func buyStock() {
//        
//    }
//    
//    
//    func fetchTradingVolumeRanking() async throws -> TradingVolumeRankingData {
//        guard !Configuration.shared.ismockEnvironment else {
//            throw StockFuctionError.notSupportMockEnv
//        }
//        
//        let response: TradingVolumeRankingData = try await NetworkManager()
//            .method(method: .GET)
//            .path(URLType.PriceURL(.volumeRanking))
//            .addHeader(field: "content-type", value: "application/json; charset=utf-8")
//            .addHeader(field: "authorization", value: Configuration.shared.accessToken)
//            .addHeader(field: "appkey", value: Configuration.shared.AppKey)
//            .addHeader(field: "appsecret", value: Configuration.shared.AppSecret)
//            .addHeader(field: "tr_id", value: "FHPST01710000")
//            .addHeader(field: "custtype", value: "P")
//            .addQuery(name: "FID_COND_MRKT_DIV_CODE", value: "J")
//            .addQuery(name: "FID_COND_SCR_DIV_CODE", value: "20171")
//            .addQuery(name: "FID_INPUT_ISCD", value: "0000")
//            .addQuery(name: "FID_DIV_CLS_CODE", value: "0")
//            .addQuery(name: "FID_BLNG_CLS_CODE", value: "0")
//            .addQuery(name: "FID_TRGT_CLS_CODE", value: "111111111")
//            .addQuery(name: "FID_TRGT_EXLS_CLS_CODE", value: "000000")
//            .addQuery(name: "FID_INPUT_PRICE_1", value: "")
//            .addQuery(name: "FID_INPUT_PRICE_2", value: "")
//            .addQuery(name: "FID_VOL_CNT", value: "")
//            .addQuery(name: "FID_INPUT_DATE_1", value: "")
//            .decode()
//        
//        return response
//    }
//}
