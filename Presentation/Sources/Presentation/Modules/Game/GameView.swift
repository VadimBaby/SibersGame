//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

import Domain

protocol GameViewOutput: AnyObject {
    func viewDidAppear()
    func didEnterDirectionCommand(_ command: String)
    func didEnterGetCommand(_ argument1: String?)
    func didEnterOpenCommand()
    func didEnterDropCommand(_ argument1: String?)
}

protocol GameViewInput: AnyObject {
    var output: GameViewOutput? { get set }
    
    func printInformationOfRoom(_ room: Room)
    func printInventory(_ inventory: Set<Item>)
    func printWinMessage()
    func printError<T: Error>(error: T)
}

final class GameView: GameViewInput {
    var output: GameViewOutput?
    
    func printInformationOfRoom(_ room: Room) {
        let directions = room.getSortedAvaliableDirections()
        let directionsString = directions.map { $0.title }.joined(separator: ", ")
        
        let itemsString = room.getSortedItems().map{ $0.name }.joined(separator: ", ")
        let coordinate = room.coordinate
        
        let coordinateString = "You are in the room [\(coordinate.x), \(coordinate.y)]."
        let doorsString = "There are \(directions.count) doors: \(directionsString)."
        
        let itemsInRoomString: String
        
        if itemsString.isEmpty {
            itemsInRoomString = "There are no items in the room"
        } else {
            itemsInRoomString = "Items in the room: \(itemsString)."
        }
        
        let fullString = "\(coordinateString) \(doorsString) \(itemsInRoomString)"
        Printer.print(fullString)
    }
    
    func printInventory(_ inventory: Set<Item>) {
        let inventoryString = Array(inventory).sorted(by: { $0.name > $1.name} ).map{ $0.name }.joined(separator: ", ")
        let fullString: String
        
        if inventoryString.isEmpty {
            fullString = "There are no items in your inventory"
        } else {
            fullString = "There are \(inventoryString) in your inventory"
        }
        
        Printer.print(fullString)
    }
    
    func printWinMessage() {
        Printer.print("You win!!!", color: .green)
    }
    
    func printError<T: Error>(error: T) {
        Printer.print(error: error)
    }
}

extension GameView: MainCoordinatorViewProtocol {
    enum TypeCommand: String {
        case N, S, W, E, get, open, drop
    }
    
    func viewDidAppear() {
        output?.viewDidAppear()
    }
    
    func didEnterString(_ value: String) {
        guard let inputCommand = Parser.parseCommand(from: value),
              let typeInputCommand = TypeCommand(rawValue: inputCommand.command) else {
            Printer.print(error: .unrecognizedCommand)
            return
        }
        
        switch typeInputCommand {
        case .N, .S, .W, .E:
            output?.didEnterDirectionCommand(typeInputCommand.rawValue)
        case .get:
            output?.didEnterGetCommand(inputCommand.firstArgument)
        case .open:
            output?.didEnterOpenCommand()
        case .drop:
            output?.didEnterDropCommand(inputCommand.firstArgument)
        }
    }
}
