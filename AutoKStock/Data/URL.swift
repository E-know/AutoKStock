//
//  NetworkData.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import Foundation

enum URLType {
    case PriceURL(priceURL)
    case OrderURL(orderURL)
    case TokenURL(tokenURL)
    case SocketURL(socketURL)

    enum priceURL: String {
        case current = "/uapi/domestic-stock/v1/quotations/inquire-price"
        case volumeRanking = "/uapi/domestic-stock/v1/quotations/volume-rank"
        case info = "/uapi/domestic-stock/v1/quotations/search-stock-info"
        case pricePerMin = "/uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice"
    }

    enum orderURL: String {
        case balance = "/uapi/domestic-stock/v1/trading/inquire-balance"
        case buy = "/uapi/domestic-stock/v1/trading/order-cash"
    }

    enum tokenURL: String {
        case issue = "/oauth2/tokenP"
        case revoke = "/oauth2/revokeP"
        case socket = "/oauth2/Approval"
    }
    
    enum socketURL: String {
        case realTimeConclusionPrice = "/tryitout/H0STCNT0"
    }

    var path: String {
        switch self {
        case .PriceURL(let type):
            return type.rawValue
        case .OrderURL(let type):
            return type.rawValue
        case .TokenURL(let type):
            return type.rawValue
        case .SocketURL(let type):
            return type.rawValue
        }
    }
}
