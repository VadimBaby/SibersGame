//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

public protocol SpawnerProvider: AnyObject {
    func getSpawner() -> SpawnStrategyProtocol
}
