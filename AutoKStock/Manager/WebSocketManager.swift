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
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: "WebSocket Error: URL을 확인해주세요"
        }
    }
}

final class WebSocketManager {
    var url: URL?
    var header = [String: String]()
    var body = [String: Any?]()
    var method: HTTPMethod = .POST
    private var webSocket: WebSocket?
    
    init() {
        let urlString = if Configuration.shared.ismockEnvironment {
            "ws://ops.koreainvestment.com:31000"
        } else {
            "ws://ops.koreainvestment.com:21000"
        }
        
        url = URL(string: urlString)
    }
    
    func path(_ path: URLType) -> Self {
        url?.append(path: path.path)
        return self
    }
    
    func method(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func addHeader(field: String, value: String?) -> Self {
        header[field] = value
        return self
    }
    
    func addBody(key: String, value: Any?) -> Self {
        body[key] = value
        return self
    }
    
    func openWebSocket(_ handler: @escaping (Data) -> ()) throws -> Self {
        guard let url = url else { throw WebSocketError.invalidURL }
        var request = URLRequest(url: url)
        
        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.httpMethod = method.rawValue
        
        print(request.description)
        
        self.webSocket = WebSocket(request: request)
        
        webSocket?.onEvent = { event in
            print(event)
            switch event {
            case .connected(let headers):
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
            case .binary(let data):
                print("Received data: \(data.count)")
                handler(data)
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
        
        return self
    }
    
    func closeWebSocket() {
        
    }
}
