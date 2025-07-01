//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

import Common

public struct Room {
    public let coordinate: Coordinate
    public let items: Set<Item>
    public let avaliableDirections: Set<Direction>
    
    public init(coordinate: Coordinate, items: Set<Item>, avaliableDirections: Set<Direction>) {
        self.coordinate = coordinate
        self.items = items
        self.avaliableDirections = avaliableDirections
    }
    
    public func getSortedAvaliableDirections() -> [Direction] {
        Array(avaliableDirections).sorted(by: { $0.rawValue > $1.rawValue })
    }
    
    public func getSortedItems() -> [Item] {
        Array(items).sorted(by: { $0.name > $1.name })
    }
    
    public func containts<T: Item>(
        typeItem: T.Type,
        where closure: ((_ item: T) -> Bool)? = nil
    ) -> Bool {
        items.contains { item in
            guard let specItem = item as? T else { return false }
            guard let closure else { return true }
            return closure(specItem)
        }
    }
    
    public func canGo(to direction: Direction) -> Bool {
        avaliableDirections.contains(direction)
    }
    
    public func canPick<T: Item>(typeItem: T.Type) -> Bool {
        containts(typeItem: typeItem, where: { $0.canPick })
    }
    
    public func get<T: Item>(typeItem: T.Type) -> T? {
        guard let item = items.first(where: { ($0 as? T).isNotNil }) else { return nil }
        return item as? T
    }
    
    public func add(items: Set<Item>) -> Room {
        return self.applying(action: .append(items))
    }
    
    public func remove(items: Set<Item>) -> Room {
        return self.applying(action: .remove(items))
    }
    
    public func set(items: Set<Item>) -> Room {
        return self.applying(action: .set(items))
    }
}

// MARK: -> Copy With

public extension Room {
    private enum ItemsAction {
        case set(_ items: Set<Item>)
        case append(_ items: Set<Item>)
        case remove(_ items: Set<Item>)
    }
    
    private func applying(action: ItemsAction) -> Room {
        switch action {
        case .set(let items):
            return Room(coordinate: coordinate, items: items, avaliableDirections: avaliableDirections)
        case .append(let items):
            let newItems = self.items.union(items)
            return Room(coordinate: coordinate, items: newItems, avaliableDirections: avaliableDirections)
        case .remove(let items):
            let newItems = self.items.subtracting(items)
            return Room(coordinate: coordinate, items: newItems, avaliableDirections: avaliableDirections)
        }
    }
}
