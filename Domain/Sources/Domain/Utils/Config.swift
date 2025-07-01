//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

public struct Config {
    public let width: Int
    public let height: Int
    public let stepsLimit: Int
    
    public init(width: Int, height: Int, stepsLimit: Int) {
        self.width = width
        self.height = height
        self.stepsLimit = stepsLimit
    }
}
