//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.06.2025.
//

public protocol GetCurrentRoomUseCaseProtocol: AnyObject {
    func execute() -> Room
}

public final class GetCurrentRoomUseCase: GetCurrentRoomUseCaseProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func execute() -> Room {
        service.getCurrentRoom()
    }
}
