//
//  File.swift
//  Main
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

import Game
import Domain

final class DataAssembly: Assembly {
    func assemble(container: Registration) {
        container.register(ItemFactoryProtocol.self) { _ in
            ItemFactory()
        }
        
        container.register(ItemParserProtocol.self) { _ in
            ItemParser()
        }
        
        container.register(FieldGeneratorProtocol.self) { resolver in
            FieldGenerator(
                configProvider: resolver.resolve(ConfigProvider.self)!,
                spawnerProvider: resolver.resolve(SpawnerProvider.self)!
            )
        }
        
        container.register(GameSettingsProtocol.self) { resolver in
            GameSettings(itemFactory: resolver.resolve(ItemFactoryProtocol.self)!)
        }.implements(ConfigProvider.self, ConfigEditor.self, FieldItemsProvider.self, SpawnerProvider.self)
        
        container.register(FieldBuilderProtocol.self) { resolver in
            FieldBuilder(
                fieldGenerator: resolver.resolve(FieldGeneratorProtocol.self)!,
                fieldItemsProvider: resolver.resolve(FieldItemsProvider.self)!
            )
        }
        
        container.register(PlayerBuilderProtocol.self) { resolver in
            PlayerBuilder(configProvider: resolver.resolve(ConfigProvider.self)!)
        }
        
        container.register(GameServiceProtocol.self, name: "impl") { resolver in
            GameService(
                fieldBuilder: resolver.resolve(FieldBuilderProtocol.self)!,
                playerBuilder: resolver.resolve(PlayerBuilderProtocol.self)!,
                itemParser: resolver.resolve(ItemParserProtocol.self)!
            )
        }
        
        container.register(GameServiceProtocol.self) { resolver in
            GameServiceLogger(service: resolver.resolve(GameServiceProtocol.self, name: "impl")!)
        }
    }
}
