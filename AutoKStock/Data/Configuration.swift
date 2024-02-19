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
    
    private lazy var tokenUserdefaultsKey: String = ismockEnvironment ? "mockToken" : "realToken"
    
    var accessToken: String? {
        set {
            if let token = newValue {
                print("토큰발급완료:\n", token)
                UserDefaults.standard.setValue(newValue, forKey: tokenUserdefaultsKey)
            } else {
                print("토큰폐기완료")
                UserDefaults.standard.removeObject(forKey: tokenUserdefaultsKey)
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
    
    lazy var accountNumber: String = ismockEnvironment ? mockAccountNumber : realAccountNumber
    var accountProductCode: String = "01"
    
    lazy var rawToken: String? = UserDefaults.standard.string(forKey: tokenUserdefaultsKey)
}
