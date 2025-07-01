//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

import Domain

public protocol GamePresenterOutput: AnyObject {
    func gameDidEnd()
}

protocol GamePresenterInput: AnyObject {
    var output: GamePresenterOutput? { get set }
}

final class GamePresenter: GamePresenterInput {
    var output: GamePresenterOutput?
    
    private unowned let view: GameViewInput
    private let interactor: GameInteractorInput
    
    init(view: GameViewInput, interactor: GameInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

extension GamePresenter: GameViewOutput {
    func viewDidAppear() {
        interactor.startGame()
    }
    
    func didEnterDirectionCommand(_ command: String) {
        interactor.move(to: command)
    }
    
    func didEnterGetCommand(_ argument1: String?) {
        interactor.pick(item: argument1)
    }
    
    func didEnterOpenCommand() {
        interactor.open()
    }
    
    func didEnterDropCommand(_ argument1: String?) {
        interactor.drop(item: argument1)
    }
}

extension GamePresenter: GameInteractorOutput {
    func gameDidStarted() {
        interactor.getCurrentRoom()
    }
    
    func roomDidGet(_ room: Room) {
        view.printInformationOfRoom(room)
    }
    
    func didMove() {
        interactor.getCurrentRoom()
    }
    
    func printError<T: Error>(_ error: T) {
        view.printError(error: error)
    }
    
    func didPickItem() {
        interactor.getInventory()
    }
    
    func inventoryDidGet(_ inventory: Set<Item>) {
        view.printInventory(inventory)
    }
    
    func chestDidOpen() {
        interactor.checkWinGame()
    }
    
    func stepsLimitDidEnd<T: Error>(_ error: T) {
        view.printError(error: error)
        output?.gameDidEnd()
    }
    
    func gameDidWon() {
        view.printWinMessage()
        output?.gameDidEnd()
    }
    
    func itemDidDrop() {
        interactor.getCurrentRoom()
    }
}
