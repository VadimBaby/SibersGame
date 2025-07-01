//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

import Domain

final class GameAssembly {
    static func assembly(coordinator: GamePresenterOutput, resolver: Resolver) -> MainCoordinatorViewProtocol {
        let view = GameView()
        let interactor = GameInteractor(
            startGameUseCase: resolver.resolve(StartGameUseCaseProtocol.self)!,
            getCurrentRoomUseCase: resolver.resolve(GetCurrentRoomUseCaseProtocol.self)!,
            moveToDirectionUseCase: resolver.resolve(MoveToDirectionUseCaseProtocol.self)!, 
            pickItemUseCase: resolver.resolve(PickItemUseCaseProtocol.self)!,
            getInventoryUseCase: resolver.resolve(GetInventoryUseCaseProtocol.self)!,
            openChestUseCase: resolver.resolve(OpenChestUseCaseProtocol.self)!,
            isGameWonUseCase: resolver.resolve(IsGameWonUseCaseProtocol.self)!,
            dropItemUseCase: resolver.resolve(DropItemUseCaseProtocol.self)!
        )
        let presenter = GamePresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = coordinator
        
        return view
    }
}
