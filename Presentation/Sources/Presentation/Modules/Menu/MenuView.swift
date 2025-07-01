//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

import Common

protocol MenuViewOutput: AnyObject {
    func didEnterStartCommand()
    func didEnterShowCommand(argument: String?)
    func didEnterSetCommand(argument1: String?, argument2: String?)
}

protocol MenuViewInput: AnyObject {
    var output: MenuViewOutput? { get set }
}

final class MenuView: MenuViewInput, MainCoordinatorViewProtocol {
    var output: MenuViewOutput?
    
    enum TypeCommand: String {
        case start, show, set
    }
    
    func viewDidAppear() {
        Printer.print("You are in menu. Type \"start\" to start the game. Type \"exit\" to exit of this app", color: .orange)
    }
    
    func didEnterString(_ value: String) {
        guard let inputCommand = Parser.parseCommand(from: value),
              let typeInputCommand = TypeCommand(rawValue: inputCommand.command) else {
            Printer.print(error: .unrecognizedCommand)
            return
        }
        
        switch typeInputCommand {
        case .start:
            output?.didEnterStartCommand()
        case .show:
            output?.didEnterShowCommand(argument: inputCommand.firstArgument)
        case .set:
            output?.didEnterSetCommand(argument1: inputCommand.firstArgument, argument2: inputCommand.secondArgument)
        }
    }
}
