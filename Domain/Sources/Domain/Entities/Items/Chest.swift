//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 30.06.2025.
//

import Foundation

public final class Chest: Item {
    private let items: Set<Item>
    
    public init(items: Set<Item>) {
        self.items = items
        super.init(id: .init(), name: "chest", canPick: false)
    }
    
    public func open(with key: Key) -> Set<Item>? {
        return items
    }
}
