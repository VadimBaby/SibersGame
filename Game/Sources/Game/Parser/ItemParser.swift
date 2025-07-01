//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 01.07.2025.
//

import Domain

public final class ItemParser: ItemParserProtocol {
    public init() {}
    
    private enum KindItem: String {
        case key, chest, grail
    }
    
    public func parse(name: String) -> Item.Type? {
        guard let kind = KindItem(rawValue: name) else { return nil }
        
        return switch kind {
        case .key: Key.self
        case .chest: Chest.self
        case .grail: Grail.self
        }
    }
}
