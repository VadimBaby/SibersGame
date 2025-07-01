//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

public protocol SpawnStrategyProtocol {
    func spawnDecision(at stepsLimit: Int, stepsSinceLastSpawn: Int?) -> Bool
}
