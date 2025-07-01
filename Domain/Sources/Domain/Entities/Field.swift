//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

import Common

public struct Field {
    public let value: [[Room]]
    
    public init(value: [[Room]]) {
        self.value = value
    }
    
    public func getRoom(from coordinate: Coordinate) -> Room {
        return value[coordinate.y][coordinate.x]
    }
    
    public func updateRoom(with coordinate: Coordinate, newRoom room: Room) -> Field {
        var updatedField = value
        updatedField[coordinate.y][coordinate.x] = room
        return Field(value: updatedField)
    }
}
