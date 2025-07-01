//
//  File.swift
//  Main
//
//  Created by Вадим Мартыненко on 28.06.2025.
//

import Domain

final class DomainAssembly: Assembly {
    func assemble(container: Registration) {
        container.register(StartGameUseCaseProtocol.self) { resolver in
            StartGameUseCase(service: resolver.resolve(GameServiceProtocol.self)!)
        }
        
        container.register(GetCurrentRoomUseCaseProtocol.self) { resolver in
            GetCurrentRoomUseCase(service: resolver.resolve(GameServiceProtocol.self)!)
        }
        
        container.register(MoveToDirectionUseCaseProtocol.self) { resolver in
            MoveToDirectionUseCase(service: resolver.resolve(GameServiceProtocol.self)!)
        }
        
        container.register(PickItemUseCaseProtocol.self) { resolver in
            PickItemUseCase(service: resolver.resolve(GameServiceProtocol.self)!)
        }
        
        container.register(GetInventoryUseCaseProtocol.self) { resolver in
            GetInventoryUseCase(service: resolver.resolve(GameServiceProtocol.self)!)
        }
        
        container.register(OpenChestUseCaseProtocol.self) { resolver in
            OpenChestUseCase(service: resolver.resolve(GameServiceProtocol.self)!)
        }
        
        container.register(IsGameWonUseCaseProtocol.self) { resolver in
            IsGameWonUseCase(service: resolver.resolve(GameServiceProtocol.self)!)
        }
        
        container.register(DropItemUseCaseProtocol.self) { resolver in
            DropItemUseCase(service: resolver.resolve(GameServiceProtocol.self)!)
        }
    }
}
