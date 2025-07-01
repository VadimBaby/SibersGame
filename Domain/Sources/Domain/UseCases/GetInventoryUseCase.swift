//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.06.2025.
//

public protocol GetInventoryUseCaseProtocol: AnyObject {
    func execute() -> Set<Item>
}

public final class GetInventoryUseCase: GetInventoryUseCaseProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func execute() -> Set<Item> {
        return service.getInventory()
    }
}
