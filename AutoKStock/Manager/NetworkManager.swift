//
//  NetworkManager.swift
//  MyMoney
//
//  Created by Inho Choi on 2/3/24.
//

import Foundation

class NetworkManager {
    private var queryDic: [String: String?]? // key(name) : value
    private var urlComponents: URLComponents?
    private var method: HTTPMethod? = .GET
    private var bodyStruct: Encodable?
    private var bodyDict: [String: Any?]?
    private var header: [(field: String, value: String?)]?
    
    init() {
        
        let domain = if Configuration.shared.ismockEnvironment {
            "https://openapivts.koreainvestment.com:29443"
        } else {
            "https://openapi.koreainvestment.com:9443"
        }
            
        
        urlComponents = URLComponents(string: domain)
    }
    
    // TODO: 이거 뭔가 깔끔하지 않아 수정 가능할지도?
    func path(_ path: URLType) -> Self {
        urlComponents?.path = path.path
        return self
    }
    
    
    func method(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func addQuery(name: String, value: String?) -> Self {
        if queryDic == nil {
            self.queryDic = .init()
        }
        
        queryDic?[name] = value
//        queryItems?.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    
    func addHeader(field: String, value: String?) -> Self {
        if header == nil {
            self.header = .init()
        }
        header?.append((field: field, value: value))
        return self
    }
    
//    func addBody(_ body: Encodable) -> Self {
//        self.bodyStruct = body
//        return self
//    }
    
    func addBody(key: String, value: Any?) -> Self {
        if bodyDict == nil {
            bodyDict = .init()
        }
        bodyDict?[key] = value
        return self
    }
    
    func decode<T: Decodable>() async throws -> T {
        if let queryDic {
            var queryItems = [URLQueryItem]()
            for (name, value) in queryDic {
                queryItems.append(URLQueryItem(name: name, value: value))
            }
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else { throw NetworkError.URLError }
        var request = URLRequest(url: url)
        request.httpMethod = method?.rawValue
        
        if let bodyDict {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyDict)
        }
        
        if let header {
            for (field, value) in header {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
        
//        print(request.description)
        
        let (data, rawResponse) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
//        print(data.description!)
        
        guard let response = rawResponse as? HTTPURLResponse, response.statusCode == 200 else {
            do {
                let jsonData = try decoder.decode(ErrorMessage.self, from: data)
                print(jsonData.description)
            } catch {
                print(error.localizedDescription)
            }
            throw NetworkError.ResponseError
        }
//        print(response.allHeaderFields)

        
        let jsonData = try decoder.decode(T.self, from: data) // Error: The data couldn’t be read because it is missing.
        
        return jsonData
    }
}


enum NetworkError: LocalizedError {
    case RequestIsNil
    case ResponseError
    case URLError
    
    public var errorDescription: String? {
        switch self {
        case .RequestIsNil: "Requset 생성에 실패했습니다."
        case .ResponseError: "HTTPURLResponse가 200이 아닙니다"
        case .URLError: "URL 생성에 실패했습니다."
        }
    }
}

enum HTTPMethod: String {
    case GET
    case POST
}
