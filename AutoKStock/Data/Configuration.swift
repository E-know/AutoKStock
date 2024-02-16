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
    
    lazy var AppKey = if ismockEnvironment {
        mockAppKey
    } else {
        appKey
    }
    
    lazy var AppSecret = if ismockEnvironment {
        mockAppSecret
    } else {
        appSecret
    }
    
    var accessToken: String? {
        didSet {
            if let accessToken {
                print("토큰 설정 완료: \(accessToken)")
            }
        }
    }
}

