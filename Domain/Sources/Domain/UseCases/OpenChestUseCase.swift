//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

import MyCommon

public protocol OpenChestUseCaseProtocol: AnyObject {
    func execute() -> OperationResult<GameServiceProtocolError>
}

public final class OpenChestUseCase: OpenChestUseCaseProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func execute() -> OperationResult<GameServiceProtocolError> {
        return service.open()
    }
}
