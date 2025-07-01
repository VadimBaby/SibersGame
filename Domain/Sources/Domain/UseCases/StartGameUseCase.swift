//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.06.2025.
//

public protocol StartGameUseCaseProtocol: AnyObject {
    func execute()
}

public final class StartGameUseCase: StartGameUseCaseProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func execute() {
        service.startGame()
    }
}
