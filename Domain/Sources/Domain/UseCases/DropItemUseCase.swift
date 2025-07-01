//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 30.06.2025.
//

import MyCommon

public protocol DropItemUseCaseProtocol: AnyObject {
    func execute(name: String) -> OperationResult<GameServiceProtocolError>
}

public final class DropItemUseCase: DropItemUseCaseProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func execute(name: String) -> OperationResult<GameServiceProtocolError> {
        return service.drop(name: name)
    }
}
