//
//  NetworkData.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import Foundation

struct NetworkData {
    static let domain = if ismockEnvironment {
        "https://openapivts.koreainvestment.com:29443"
    } else {
        "https://openapi.koreainvestment.com:9443"
    }
}

enum PriceURL: String {
    case now = "/uapi/domestic-stock/v1/quotations/inquire-price"
}

enum OrderURL: String {
    case buy = "A"
}
