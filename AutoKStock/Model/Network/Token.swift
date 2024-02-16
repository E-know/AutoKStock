//
//  Token.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import Foundation

struct IssueTokenInput: Encodable {
    let grant_type = "client_credentials"
    let appkey = Configuration.shared.AppKey
    let appsecret = Configuration.shared.AppSecret
}

struct IssueTokenOutput: Decodable {
    let accessToken, accessTokenTokenExpired, tokenType: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case accessTokenTokenExpired = "access_token_token_expired"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}

struct RevokeTokenInput: Encodable {
    let appkey = Configuration.shared.AppKey
    let appsecret = Configuration.shared.AppSecret
    let token: String
}

struct RevokeTokenOutput: Decodable {
    let code: Int
    let message: String
}
