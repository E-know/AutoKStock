//
//  Data+.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/19/24.
//

import Foundation

extension Data {
    var description: String? {
        String(data: self, encoding: .utf8)
    }
}
