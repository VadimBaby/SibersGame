//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

import Common
import Domain
import Foundation
import MyCommon

public final class GameService: GameServiceProtocol {
    private let fieldBuilder: FieldBuilderProtocol
    private let playerBuilder: PlayerBuilderProtocol
    private let itemParser: ItemParserProtocol

    private var field: Field!
    private var player: Player!
    
    public init(
        fieldBuilder: FieldBuilderProtocol,
        playerBuilder: PlayerBuilderProtocol,
        itemParser: ItemParserProtocol
    ) {
        self.fieldBuilder = fieldBuilder
        self.playerBuilder = playerBuilder
        self.itemParser = itemParser
    }
    
    private var currentRoom: Room {
        getCurrentRoom()
    }
    
    public func startGame() {
        self.player = playerBuilder.createPlayer()
        self.field = fieldBuilder.createField(startCoordinate: player.coordinate)
    }
    
    public func getField() -> Field? {
        field
    }
    
    public func getCurrentRoom() -> Room {
        return field.getRoom(from: player.coordinate)
    }
    
    public func getInventory() -> Set<Item> {
        return player.inventory
    }
    
    public func isGameWon() -> Bool {
        player.has(typeItem: Grail.self)
    }
    
    public func open() -> OperationResult<GameServiceProtocolError> {
        guard let key = player.get(typeItem: Key.self) else { return .failure(.noKeyInInventory) }
        guard let chest = currentRoom.get(typeItem: Chest.self) else { return .failure(.noChestInRoom) }
        guard let openedItems = chest.open(with: key) else { return .failure(.cantOpenChestWithThisKey) }
        
        let newRoom = currentRoom.remove(items: [chest])
        
        self.player = player.give(items: openedItems)
        self.field = field.updateRoom(with: player.coordinate, newRoom: newRoom)
        
        return .success
    }
    
    public func move(to direction: Direction) -> OperationResult<GameServiceProtocolError> {
        guard currentRoom.canGo(to: direction) else { return .failure(.cantMove) }
        guard let movedPlayer = player.move(to: direction) else { return .failure(.stepsLimitIsEnd) }
        self.player = movedPlayer
        return .success
    }
    
    public func pick(name: String) -> OperationResult<GameServiceProtocolError> {
        guard let typeItem = itemParser.parse(name: name),
              currentRoom.containts(typeItem: typeItem) else { return .failure(.noItem(name)) }
        
        guard currentRoom.canPick(typeItem: typeItem),
              let item = currentRoom.get(typeItem: typeItem) else { return .failure(.cantPick(name)) }
        
        let newRoom = currentRoom.remove(items: [item])
        
        self.player = player.give(items: [item])
        self.field = field.updateRoom(with: player.coordinate, newRoom: newRoom)
        return .success
    }
    
    public func drop(name: String) -> OperationResult<GameServiceProtocolError> {
        guard let typeItem = itemParser.parse(name: name),
              let item = player.get(typeItem: typeItem) else { return .failure(.noItem(name)) }
        
        self.player = player.remove(items: [item])
        
        let newRoom = currentRoom.add(items: [item])
        self.field = field.updateRoom(with: player.coordinate, newRoom: newRoom)
        
        return .success
    }
}
