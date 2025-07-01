//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

import Domain

struct EasySpawnStrategy: SpawnStrategyProtocol {
    func spawnDecision(at stepsLimit: Int, stepsSinceLastSpawn: Int?) -> Bool {
        let percent: Int
        
        if stepsLimit <= 2 {
            percent = 100
        } else if stepsLimit < 4 {
            percent = 100 / stepsLimit
        } else {
            percent = 10
        }
        
        if percent >= Int.random(in: 0...100) {
            return true
        }
                                 
        return false
    }
}
