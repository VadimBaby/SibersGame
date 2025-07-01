//
//  File.swift
//  Common
//
//  Created by Вадим Мартыненко on 28.06.2025.
//

public struct Coordinate {
    public let x: Int
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public func move(direction: Direction) -> Coordinate {
        var x = self.x
        var y = self.y
        
        switch direction {
        case .north: y -= 1
        case .south: y += 1
        case .west:  x -= 1
        case .east:  x += 1
        }
        
        return Coordinate(x: x, y: y)
    }
}
