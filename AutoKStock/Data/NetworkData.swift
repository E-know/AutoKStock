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

    enum priceURL: String {
        case now = "/uapi/domestic-stock/v1/quotations/inquire-price"
        case volumeRanking = "/uapi/domestic-stock/v1/quotations/volume-rank"
    }

    enum orderURL: String {
        case buy = "/uapi/domestic-stock/v1/trading/order-cash"
    }

    enum tokenURL: String {
        case issue = "/oauth2/tokenP"
        case revoke = "/oauth2/revokeP"
    }
    
    

    var path: String {
        switch self {
        case .PriceURL(let type):
            return type.rawValue
        case .OrderURL(let type):
            return type.rawValue
        case .TokenURL(let type):
            return type.rawValue
        }
    }
}
