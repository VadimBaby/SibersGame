//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

import Domain
import Common

public final class PlayerBuilder: PlayerBuilderProtocol {
    private let configProvider: ConfigProvider
    
    public init(configProvider: ConfigProvider) {
        self.configProvider = configProvider
    }
    
    public func createPlayer() -> Player {
        let config = configProvider.getConfig()
        let coordinate = generateStartCoordinate(width: config.width, height: config.height)
        return Player(coordinate: coordinate, inventory: [], stepsLimit: config.stepsLimit)
    }
}

//MARK: - Private

private extension PlayerBuilder {
    func generateStartCoordinate(width: Int, height: Int) -> Coordinate {
        let x = Int.random(in: 0..<width)
        let y = Int.random(in: 0..<height)
        return Coordinate(x: x, y: y)
    }
}
