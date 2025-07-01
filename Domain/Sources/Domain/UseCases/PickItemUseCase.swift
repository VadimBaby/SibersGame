//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.06.2025.
//

import MyCommon

public protocol PickItemUseCaseProtocol: AnyObject {
    func execute(item: String) -> OperationResult<GameServiceProtocolError>
}

public final class PickItemUseCase: PickItemUseCaseProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func execute(item: String) -> OperationResult<GameServiceProtocolError> {
        return service.pick(name: item)
    }
}
