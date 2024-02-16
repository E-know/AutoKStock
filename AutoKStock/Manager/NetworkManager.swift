//
//  NetworkManager.swift
//  MyMoney
//
//  Created by Inho Choi on 2/3/24.
//

import Foundation

class NetworkManager {
    private var queryItems = [URLQueryItem]()
    private var urlComponents: URLComponents?
    private var method: HTTPMethod? = .GET
    private var body: Encodable?
    
    init() {
        urlComponents = URLComponents(string: NetworkData.domain)
    }
    
    func path(_ path: PriceURL) -> Self {
        urlComponents?.path = path.rawValue
        return self
    }
    
    // TODO: 이거 뭔가 깔끔하지 않아 수정 가능할지도?
    func path(_ path: OrderURL) -> Self {
        urlComponents?.path = path.rawValue
        return self
    }
    
    func method(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func addHeader(name: String, value: String?) -> Self {
        queryItems.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    func addBody(_ body: Encodable) -> Self {
        self.body = body
        return self
    }
    
    func decode<T: Decodable>() async throws -> T {
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { throw NetworkError.URLError }
        
        let request = URLRequest(url: url)
        let (data, rawResponse) = try await URLSession.shared.data(for: request)
        
        
        guard let response = rawResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.ResponseError
        }
        
        
        let jsonData = try JSONDecoder().decode(T.self, from: data)
        
        return jsonData
    }
}


enum NetworkError: Error {
    case RequestIsNil
    case ResponseError
    case URLError
    case URLComponentsError
    case QueryItemError
}

enum HTTPMethod: String {
    case GET
    case POST
}