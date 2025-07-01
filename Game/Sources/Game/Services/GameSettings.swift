//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

import Domain

public final class GameSettings: GameSettingsProtocol {
    private var config = Config(width: 10, height: 10, stepsLimit: 10)
    private let spawner = EasySpawnStrategy()
    
    private let itemFactory: ItemFactoryProtocol
    
    public init(itemFactory: ItemFactoryProtocol) {
        self.itemFactory = itemFactory
    }
    
    public func getConfig() -> Config {
        return config
    }
    
    public func changeConfig(_ config: Config) {
        self.config = config
    }
    
    public func getSpawner() -> SpawnStrategyProtocol {
        spawner
    }
    
    public func getFieldItems() -> Set<Item> {
        let key = itemFactory.createKeyItem()
        let chest = itemFactory.createChestItem()
        return [key, chest]
    }
}
