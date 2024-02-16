//
//  NetworkData.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import Foundation

enum PriceURL: String {
    case now = "/uapi/domestic-stock/v1/quotations/inquire-price"
}

enum OrderURL: String {
    case buy = "A"
}

enum TokenURL: String {
    case issue = "/oauth2/tokenP"
    case revoke = "/oauth2/revokeP"
}
