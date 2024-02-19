//
//  Key.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import Foundation

final class Configuration {
    private init() { }
    static let shared = Configuration()
    
    var ismockEnvironment = true
    
    lazy var AppKey = ismockEnvironment ? mockAppKey : appKey
    lazy var AppSecret = ismockEnvironment ? mockAppSecret : appSecret
    
    var accessToken: String? {
        set {
            if let token = newValue {
                print("토큰발급완료:\n", token)
            }
            rawToken = newValue
        }
        get {
            if let rawToken {
                "Bearer " + rawToken
            } else {
                nil
            }
        }
    }
    
    lazy var accountNumber: String = ismockEnvironment ? mockAccountNumber : accountNumber
    var accountProductCode: String = "01"
    
    var rawToken: String?
}
