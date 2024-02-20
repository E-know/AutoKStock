//
//  Error.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/19/24.
//

import Foundation

enum EnvError: Error, LocalizedError {
    case notSupportMockEnv
    
    
    public var errorDescription: String? {
        switch self {
        case.notSupportMockEnv: "모의투자환경에서는 지원하지 않습니다."
        }
    }
}

struct ErrorMessage: Decodable {
    let rtCd: String
    let msgCd: String
    let msg1: String
    
    var description: String {
        "Server] ErrorCode: \(msgCd)\nMessage: \(msg1)\nrtCd: \(rtCd)"
    }
}
