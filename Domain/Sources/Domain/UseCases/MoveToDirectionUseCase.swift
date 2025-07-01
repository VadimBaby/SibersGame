//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.06.2025.
//

import Common
import MyCommon

public protocol MoveToDirectionUseCaseProtocol: AnyObject {
    func execute(direction: Direction) -> OperationResult<GameServiceProtocolError>
}

public final class MoveToDirectionUseCase: MoveToDirectionUseCaseProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func execute(direction: Direction) -> OperationResult<GameServiceProtocolError> {
        return service.move(to: direction)
    }
}
