//
//  OrderManager.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/19/24.
//

import Foundation

class OrderManager {
    private init() { }
    static let shared = OrderManager()
    
    func fetchBalance() async throws -> BalanceData {
        let response: BalanceData = try await NetworkManager()
            .method(method: .GET)
            .path(URLType.OrderURL(.balance))
            .addHeader(field: "content-type", value: "application/json; charset=utf-8")
            .addHeader(field: "authorization", value: Configuration.shared.accessToken)
            .addHeader(field: "appkey", value: Configuration.shared.AppKey)
            .addHeader(field: "appsecret", value: Configuration.shared.AppSecret)
            .addHeader(field: "tr_id", value: Configuration.shared.ismockEnvironment ? "VTTC8434R" : "TTTC8434R")
            .addQuery(name: "CANO", value: Configuration.shared.accountNumber)
            .addQuery(name: "ACNT_PRDT_CD", value: Configuration.shared.accountProductCode)
            .addQuery(name: "AFHR_FLPR_YN", value: "N")
            .addQuery(name: "OFL_YN", value: "")
            .addQuery(name: "INQR_DVSN", value: "01")
            .addQuery(name: "UNPR_DVSN", value: "01")
            .addQuery(name: "FUND_STTL_ICLD_YN", value: "Y")
            .addQuery(name: "FNCG_AMT_AUTO_RDPT_YN", value: "N")
            .addQuery(name: "PRCS_DVSN", value: "00")
            .addQuery(name: "CTX_AREA_FK100", value: "")
            .addQuery(name: "CTX_AREA_NK100", value: "")
            .decode()
        
        return response
    }
    
    func buyStock() {
        let response = NetworkManager()
            .method(method: .POST)
            .path(URLType.OrderURL(.buy))
            .addHeader(field: "content-type", value: "application/json; charset=utf-8")
    }
}
