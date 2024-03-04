//
//  NTree.swift
//  TestSwiftUI
//
//  Created by Inho Choi on 3/4/24.
//

import Foundation

class NTree {
    var children = [Character: NTree]()
    var isLeaf: Bool {
        elements.count == 0
    }
    var elements = [StockInfo]()
    
    
    func append(_ name: String, productCode: String) {
        let chars = name.decomposedStringWithCompatibilityMapping.unicodeScalars.map { Character($0) }.reversed()
        
        addChild(name, productCode: productCode, chars: Array(chars))
    }
    
    private func addChild(_ name: String, productCode: String, chars: [Character]) {
        
        var chars = chars
        var node = self
        
        while chars.count > 0 {
            let char = chars.removeLast()
            
            if let tempNode = node.children[char] {
                node = tempNode
            } else {
                node.children[char] = NTree()
                node = node.children[char]!
            }
        }
        
        node.elements.append(StockInfo(productCode: productCode, name: name))
    }
    
    func find(name: String) -> [StockInfo] {
        var chars = Array(name.decomposedStringWithCompatibilityMapping.unicodeScalars.map { Character($0) }.reversed())
        
        var node = self
        
        while chars.count > 0 {
            let char = chars.removeLast()
            
            guard let tempNode = node.children[char] else { break }
            node = tempNode
        }
        
        return node.preorderTraversal()
    }
    
    
    func preorderTraversal() -> [StockInfo] {
        var arr = [StockInfo]()
        
        for key in self.children.keys.sorted() {
            guard let child = self.children[key] else { continue }
            arr += child.preorderTraversal()
        }
        
        return self.elements + arr
    }
}
