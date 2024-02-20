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
            .addHeader(field: "content-type", value: "application/json; charset=utf-8")
            .addHeader(field: "authorization", value: Configuration.shared.accessToken)
            .addHeader(field: "appkey", value: Configuration.shared.AppKey)
            .addHeader(field: "appsecret", value: Configuration.shared.AppSecret)
            .addHeader(field: "tr_id", value: "CTPF1002R")
            .addHeader(field: "custtype", value: "P")
            .addQuery(name: "PRDT_TYPE_CD", value: "300")
            .addQuery(name: "PDNO", value: productNumber)
            .decode()
        
        return response
    }
    
    func getPricePerMin(productNumber: String) async throws -> PricePerMinData {
        var time = Date.krStockOpenDate.addingTimeInterval(60 * 30) // + 30분
        let now = Date.now < Date.krStockCloseDate ? Date.now : Date.krStockCloseDate
        print(now.toString)
        var data = Set<PriceMinuteData>()
        let network = NetworkManager()
            .method(method: .GET)
            .path(URLType.PriceURL(.pricePerMin))
            .addHeader(field: "content-type", value: "application/json; charset=utf-8")
            .addHeader(field: "authorization", value: Configuration.shared.accessToken)
            .addHeader(field: "appkey", value: Configuration.shared.AppKey)
            .addHeader(field: "appsecret", value: Configuration.shared.AppSecret)
            .addHeader(field: "tr_id", value: "FHKST03010200")
            .addHeader(field: "custtype", value: "P")
            .addQuery(name: "FID_ETC_CLS_CODE", value: "")
            .addQuery(name: "FID_COND_MRKT_DIV_CODE", value: "J")
            .addQuery(name: "FID_INPUT_ISCD", value: productNumber)
            .addQuery(name: "FID_PW_DATA_INCU_YN", value: "N")
        
        while time < now {
            do {
                let response: PricePerMinData = try await network
                    .addQuery(name: "FID_INPUT_HOUR_1", value: time.toString) // 당일 오전 9시-9시30분 부터 30분 간격 조회
                    .decode()
                
                data = data.union(response.output2)
            
                time = time.addingTimeInterval(1800) // 60 * 30(30분)
            } catch {
                print(error.localizedDescription)
            }
            
            usleep(250000) // 0.25sec
        }
        print("DONE")
        
        var response: PricePerMinData = try await network
            .addQuery(name: "FID_INPUT_HOUR_1", value: Date.now.toString)
            .decode()
        data = data.union(response.output2)
        
        
        response.output2 = Array(data).sorted { $0.stckCntgHour < $1.stckCntgHour }
        
        return response
    }
}
