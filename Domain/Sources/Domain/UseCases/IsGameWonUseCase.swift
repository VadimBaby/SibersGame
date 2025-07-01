//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

public protocol IsGameWonUseCaseProtocol: AnyObject {
    func execute() -> Bool
}

public final class IsGameWonUseCase: IsGameWonUseCaseProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func execute() -> Bool {
        return service.isGameWon()
    }
}
