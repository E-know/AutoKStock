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
        MockAppKey
    } else {
        AppKey
    }
    
    lazy var AppSecret = if ismockEnvironment {
        MockAppSecret
    } else {
        AppSecret
    }
    
    var accessToken: String? {
        didSet {
            if let accessToken {
                print("토큰 설정 완료: \(accessToken)")
            }
        }
    }
}

