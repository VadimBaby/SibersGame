//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

import Common

public struct Player {
    public let coordinate: Coordinate
    public let inventory: Set<Item>
    public let stepsLimit: Int
    
    public init(coordinate: Coordinate, inventory: Set<Item>, stepsLimit: Int) {
        self.coordinate = coordinate
        self.inventory = inventory
        self.stepsLimit = stepsLimit
    }
    
    public func move(to direction: Direction) -> Player? {
        guard stepsLimit > 0 else { return nil }
        
        let newCoordinate = coordinate.move(direction: direction)
        let newStepsLimit = stepsLimit - 1
        return Player(coordinate: newCoordinate, inventory: inventory, stepsLimit: newStepsLimit)
    }
    
    public func give(items: Set<Item>) -> Player {
        var newInventory = inventory
        
        for item in items {
            newInventory.insert(item)
        }
        
        return Player(coordinate: coordinate, inventory: newInventory, stepsLimit: stepsLimit)
    }
    
    public func has<T: Item>(typeItem: T.Type) -> Bool {
        inventory.contains(where: { ($0 as? T).isNotNil })
    }
    
    public func get<T: Item>(typeItem: T.Type) -> T? {
        guard let item = inventory.first(where: { ($0 as? T).isNotNil }) else { return nil }
        return item as? T
    }
    
    public func remove(items: Set<Item>) -> Player {
        var newInventory = inventory
        
        for item in items {
            newInventory.remove(item)
        }
        
        return Player(coordinate: coordinate, inventory: newInventory, stepsLimit: stepsLimit)
    }
}
