//
//  WebSocketResponse.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/29/24.
//

import Foundation

protocol WebsocketData {}

struct WebSocketResponseData: Decodable, WebsocketData {
    let header: WebSocketResponseBodyHeader
    let body: WebSocketResponseBody?
}

struct WebSocketResponseBody: Decodable {
    let rtCd: String
    let msgCd: String
    let msg1: WebSocketResponseBodyMessage
    let output: WebSocketResponseBodyBodyOutput
}

// MARK: - Output
struct WebSocketResponseBodyBodyOutput: Decodable {
    let iv: String
    let key: String
}

// MARK: - Header
struct WebSocketResponseBodyHeader: Decodable {
    let trId: WebSocketResponseTradeId
    let trKey: String?
    let encrypt: String?
    let datetime: String?
}


enum WebSocketResponseBodyMessage: String, Decodable {
    case Subscribe = "SUBSCRIBE SUCCESS"
    case Unsubscribe = "UNSUBSCRIBE SUCCESS"
}

enum WebSocketResponseTradeId: String, Decodable {
    case LiveConclusion = "H0STCNT0"
    case Pingpong = "PINGPONG"
}
