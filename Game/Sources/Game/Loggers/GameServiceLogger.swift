//
//  File.swift
//  Game
//
//  Created by Вадим Мартыненко on 01.07.2025.
//

import Domain
import MyCommon
import Common

public final class GameServiceLogger: GameServiceProtocol {
    private let service: GameServiceProtocol
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
    
    public func getField() -> Field? {
        service.getField()
    }
    
    public func getCurrentRoom() -> Room {
        service.getCurrentRoom()
    }
    
    public func move(to direction: Direction) -> OperationResult<GameServiceProtocolError> {
        service.move(to: direction)
    }
    
    public func startGame() {
        service.startGame()
        
        if let field = service.getField() {
            printMatrix(field.value)
        } else {
            print("field is nil")
        }
    }
    
    public func pick(name: String) -> OperationResult<GameServiceProtocolError> {
        service.pick(name: name)
    }
    
    public func getInventory() -> Set<Item> {
        service.getInventory()
    }
    
    public func open() -> OperationResult<GameServiceProtocolError> {
        service.open()
    }
    
    public func isGameWon() -> Bool {
        service.isGameWon()
    }
    
    public func drop(name: String) -> OperationResult<GameServiceProtocolError> {
        service.drop(name: name)
    }
}

// MARK: - Private Methods

private extension GameServiceLogger {
    func printMatrix(_ matrix: [[Room]]) {
        for row in matrix {
            var printString = ""
            
            for room in row {
                var currentString = ""
                
                defer { printString.append(currentString) }
                
                if !printString.isEmpty { currentString = ", " }
                
                guard !room.items.isEmpty else { currentString.append("0"); continue }
                
                var itemsString = ""
                
                if room.containts(typeItem: Chest.self) {
                    itemsString = "chest"
                }
                
                if room.containts(typeItem: Key.self) {
                    itemsString.append(itemsString.isEmpty ? "key" : ", key")
                }
                
                currentString.append(itemsString)
            }
            
            print(printString)
        }
    }
}
