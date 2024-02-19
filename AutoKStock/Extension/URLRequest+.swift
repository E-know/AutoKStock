//
//  URLRequest+.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/17/24.
//

import Foundation

extension URLRequest {
    var description: String {
        var result = "\n"
        
        if let url = self.url {
            result += "URL: \(url.absoluteString)"
        }
        
        if let allHTTPHeaderFields {
            result += "Header (feild: value)\n"
            
            for key in allHTTPHeaderFields.keys {
                result += "\(key): \(allHTTPHeaderFields[key])\n"
            }
        }
        
        do {
            if let httpBody, let json = try JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any] {
                result += "Body\n"
                
                for key in json.keys {
                    print("\(key): \(json[key])\n")
                }
            }
        } catch {
            
        }
        
        return result
    }
}
