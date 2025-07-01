//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.06.2025.
//

import Common
import MyCommon
import Foundation

public enum GameServiceProtocolError: LocalizedError {
    case cantMove
    case cantPick(_ name: String)
    case noKeyInInventory
    case noChestInRoom
    case stepsLimitIsEnd
    case noItem(_ name: String)
    case cantOpenChestWithThisKey
    
    public var errorDescription: String? {
        switch self {
        case .cantMove: "You cant move to this coordinate"
        case .noItem(let item): "There is no item with name: \(item)"
        case .noKeyInInventory: "You haven't key in inventory"
        case .noChestInRoom: "There are no chest in the room"
        case .stepsLimitIsEnd: "Your steps limit is end. You lose"
        case .cantPick(let item): "You cant pick item with name \(item)"
        case .cantOpenChestWithThisKey: "You cant open this chest using this key"
        }
    }
}

public protocol GameServiceProtocol: AnyObject {
    func getCurrentRoom() -> Room
    func move(to direction: Direction) -> OperationResult<GameServiceProtocolError>
    func startGame()
    func pick(name: String) -> OperationResult<GameServiceProtocolError>
    func getInventory() -> Set<Item>
    func open() -> OperationResult<GameServiceProtocolError>
    func isGameWon() -> Bool
    func drop(name: String) -> OperationResult<GameServiceProtocolError>
    func getField() -> Field?
}
