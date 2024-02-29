//
//  WebSocketManager.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/22/24.
//

import Foundation
import Starscream

enum WebSocketError: LocalizedError {
    case invalidURL
    case webSocketNil
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: "WebSocket Error: URL을 확인해주세요"
        case .webSocketNil: "WebSocket Nil: register 전에 openWebSocket 함수를 먼저 실행시켜주세요."
        }
    }
}

final class WebSocketManager {
    static let shared = WebSocketManager()
    var url: URL?
    var header = [String: String]()
    var body = [String: Any?]()
    var method: HTTPMethod = .POST
    private var webSocket: WebSocket?
    
    private init() {
        let urlString = if Configuration.shared.ismockEnvironment {
            "ws://ops.koreainvestment.com:31000"
        } else {
            "ws://ops.koreainvestment.com:21000"
        }
        
        url = URL(string: urlString)
    }
    
    func openWebSocket(path: URLType, _ handler: @escaping (LiveConclusionData) -> ()) throws {
        guard var url = url else { throw WebSocketError.invalidURL }
        url.append(path: path.path)
        let request = URLRequest(url: url)
        
        self.webSocket = WebSocket(request: request)
        
        webSocket?.onEvent = { [weak self] event in
            switch event {
            case .connected(let headers):
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
                let message = self?.distinguishString(string)
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                print("Cancled By Server")
            case .error(let error):
                print(error?.localizedDescription ?? "Error in Websocket")
            case .peerClosed:
                print("PeerClosed")
            }
        }
        
        webSocket?.connect()
    }
    
    func register(productNumber: String, _ handler: @escaping () -> ()) throws {
        guard let webSocket else { throw WebSocketError.webSocketNil }
        let header: [String: Any?] = [
            "approval_key": Configuration.shared.realTimeToken,
            "custtype": "P",
            "tr_type": "1",
            "content-type": "utf-8"
        ]
        
        let body: [String: Any] = [
            "input": [
                "tr_id": "H0STCNT0",
                "tr_key": productNumber
            ]
        ]
        
        let requestData: [String: Any] = [
            "header": header,
            "body": body
        ]
        
        let data = try JSONSerialization.data(withJSONObject: requestData)
        
        // FIXME: 이 부분 handler 작동 안함 아마도 소켓에 응답 받아오는데 실패하는듯 커텍트 성공에 대한게 없음
        webSocket.write(data: data) {
            handler()
        }
        
    }
    
    func cancellation(productNumber: String) throws {
        guard let webSocket else { throw WebSocketError.webSocketNil }
        let header: [String: Any?] = [
            "approval_key": Configuration.shared.realTimeToken,
            "custtype": "P",
            "tr_type": "2",
            "content-type": "utf-8"
        ]
        
        let body: [String: Any] = [
            "input": [
                "tr_id": "H0STCNT0",
                "tr_key": productNumber
            ]
        ]
        
        let requestData: [String: Any] = [
            "header": header,
            "body": body
        ]
        
        let data = try JSONSerialization.data(withJSONObject: requestData)
        
        webSocket.write(data: data) {
            print("Send Data:", String(data: data, encoding: .utf8) ?? "")
        }
    }
    
    
    // TODO: Nil -> thorws
    private func distinguishString(_ str: String) -> WebsocketData? {
        guard let firstChar = str.first else { return nil }
        
        if firstChar == "{" {
            // JSON
            guard let data = str.data(using: .utf8) else { return nil }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let message = try jsonDecoder.decode(WebSocketResponseData.self, from: data)
                return message
            } catch {
                print(error.localizedDescription)
            }
        } else {
            // 체결 데이터
            let message = LiveConclusionData(stringData: str)
            
            return message
        }
        
        return nil
    }
}
