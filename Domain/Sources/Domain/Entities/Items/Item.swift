//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

import Foundation

public class Item: Hashable {
    public let id: UUID
    public let name: String
    public let canPick: Bool
    
    public init(id: UUID, name: String, canPick: Bool) {
        self.id = id
        self.name = name
        self.canPick = canPick
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
}

