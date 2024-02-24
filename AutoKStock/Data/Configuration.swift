//
//  Key.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import AppKit

final class Configuration {
    private init() { }
    static let shared = Configuration()
    
    var ismockEnvironment = true
    
    lazy var AppKey = ismockEnvironment ? mockAppKey : appKey
    lazy var AppSecret = ismockEnvironment ? mockAppSecret : appSecret
    
    private lazy var tokenUserdefaultsKey: String = ismockEnvironment ? "mockToken" : "realToken"
    private let tokenExpieredDateKey = "tokenExpiredDate"
    private lazy var realTimeTokenKey = ismockEnvironment ? "mockRealTimeToken" : "realTimeToken"
    
    var accessToken: String? {
        set {
            if newValue != nil {
                UserDefaults.standard.setValue(newValue, forKey: tokenUserdefaultsKey)
            } else {
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
    
    var tokenExpiredDate: Date? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: tokenExpieredDateKey)
            rawtokenExpiredDate = newValue
        }
        get {
            rawtokenExpiredDate
        }
    }
    
    lazy var accountNumber: String = ismockEnvironment ? mockAccountNumber : realAccountNumber
    var accountProductCode: String = "01"
    
    lazy var rawToken: String? = UserDefaults.standard.string(forKey: tokenUserdefaultsKey)
    lazy var rawtokenExpiredDate: Date? = UserDefaults.standard.object(forKey: tokenExpieredDateKey) as? Date
    
    let screenSize = CGSize(width: NSScreen.main!.frame.size.width / 2, height: NSScreen.main!.frame.size.height / 2) // 지금 보여지고 있는 화면 기준 크기 4K 
    
    var isTokenExpired: Bool {
        if accessToken == nil || tokenExpiredDate == nil {
            return true
        } else {
            guard accessToken != nil, let tokenExpiredDate else { return true }
            
            return tokenExpiredDate < Date.now
        }
    }
    
    var tokenDescription: String {
        var result = "토큰 발급여부: "
        
        result += (accessToken != nil ? "Y" : "N") + "\t"
        result += "만료일자: " + (tokenExpiredDate?.description ?? "<오류>")
        
        return result
    }
    
    var realTimeToken: String? {
        get {
            realTimeTokenRaw
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: realTimeTokenKey)
            realTimeTokenRaw = newValue
            print("실시간 접속키 발급이 완료되었습니다. \(newValue)")
        }
    }
    
    lazy var realTimeTokenRaw: String? = UserDefaults.standard.string(forKey: self.realTimeTokenKey)
}
