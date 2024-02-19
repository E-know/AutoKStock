//
//  TokenManager.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/19/24.
//

import Foundation

class TokenManager {
    private init() { }
    static let shared = TokenManager()
    
    func getToken() async throws -> IssueTokenData {
        let response: IssueTokenData = try await NetworkManager()
            .method(method: .POST)
            .path(URLType.TokenURL(.issue))
            .addBody(key: "grant_type", value: "client_credentials")
            .addBody(key: "appkey", value: Configuration.shared.AppKey)
            .addBody(key: "appsecret", value: Configuration.shared.AppSecret)
            .decode()
        
        return response
    }
    
    func revokeToken() async throws -> RevokeTokenData {
        let response: RevokeTokenData = try await NetworkManager()
            .method(method: .POST)
            .path(URLType.TokenURL(.revoke))
            .addBody(key: "appkey", value: Configuration.shared.AppKey)
            .addBody(key: "appsecret", value: Configuration.shared.AppSecret)
            .addBody(key: "token", value: Configuration.shared.rawToken)
            .decode()
        
        return response
    }
}
