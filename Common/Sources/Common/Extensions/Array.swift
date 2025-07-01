//
//  File.swift
//  Common
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

public extension Array {
    func hasElement(index: Int) -> Bool {
        index.isPositive && index < count
    }
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
