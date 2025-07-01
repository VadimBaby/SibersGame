//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

import Domain

public final class ItemFactory: ItemFactoryProtocol {
    public init() {}
    
    public func createKeyItem() -> Key {
        return Key()
    }
    
    public func createChestItem() -> Chest {
        let grail = createGrailItem()
        return Chest(items: [grail])
    }
    
    public func createGrailItem() -> Grail {
        return Grail()
    }
}
