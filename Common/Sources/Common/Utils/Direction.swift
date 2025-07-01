//
//  File.swift
//  Common
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

public enum Direction: Int, CaseIterable {
    case north, south, west, east
    
    public var title: String {
        switch self {
        case .north: "N"
        case .south: "S"
        case .west: "W"
        case .east: "E"
        }
    }
    
    public init?(title: String) {
        guard let direction = Self.allCases.first(where: { $0.title == title }) else { return nil }
        self = direction
    }
    
    public static func random() -> Self {
        allCases.randomElement()!
    }
    
    public static func getAll() -> Set<Self> {
        Set(allCases)
    }
}
