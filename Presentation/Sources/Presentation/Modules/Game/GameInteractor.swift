//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

import Domain
import Common

protocol GameInteractorOutput: AnyObject {
    func gameDidStarted()
    func roomDidGet(_ room: Room)
    func didMove()
    func didPickItem()
    func inventoryDidGet(_ inventory: Set<Item>)
    func printError<T: Error>(_ error: T)
    func chestDidOpen()
    func stepsLimitDidEnd<T: Error>(_ error: T)
    func gameDidWon()
    func itemDidDrop()
}

protocol GameInteractorInput: AnyObject {
    var output: GameInteractorOutput? { get set }
    
    func startGame()
    func getCurrentRoom()
    func move(to direction: String)
    func pick(item: String?)
    func getInventory()
    func open()
    func checkWinGame()
    func drop(item: String?)
}

final class GameInteractor: GameInteractorInput {
    weak var output: GameInteractorOutput?
    
    private let startGameUseCase: StartGameUseCaseProtocol
    private let getCurrentRoomUseCase: GetCurrentRoomUseCaseProtocol
    private let moveToDirectionUseCase: MoveToDirectionUseCaseProtocol
    private let pickItemUseCase: PickItemUseCaseProtocol
    private let getInventoryUseCase: GetInventoryUseCaseProtocol
    private let openChestUseCase: OpenChestUseCaseProtocol
    private let isGameWonUseCase: IsGameWonUseCaseProtocol
    private let dropItemUseCase: DropItemUseCaseProtocol
    
    init(startGameUseCase: StartGameUseCaseProtocol, getCurrentRoomUseCase: GetCurrentRoomUseCaseProtocol, moveToDirectionUseCase: MoveToDirectionUseCaseProtocol, pickItemUseCase: PickItemUseCaseProtocol, getInventoryUseCase: GetInventoryUseCaseProtocol, openChestUseCase: OpenChestUseCaseProtocol, isGameWonUseCase: IsGameWonUseCaseProtocol, dropItemUseCase: DropItemUseCaseProtocol) {
        self.startGameUseCase = startGameUseCase
        self.getCurrentRoomUseCase = getCurrentRoomUseCase
        self.moveToDirectionUseCase = moveToDirectionUseCase
        self.pickItemUseCase = pickItemUseCase
        self.getInventoryUseCase = getInventoryUseCase
        self.openChestUseCase = openChestUseCase
        self.isGameWonUseCase = isGameWonUseCase
        self.dropItemUseCase = dropItemUseCase
    }
    
    func startGame() {
        startGameUseCase.execute()
        output?.gameDidStarted()
    }
    
    func getCurrentRoom() {
        let room = getCurrentRoomUseCase.execute()
        output?.roomDidGet(room)
    }
    
    func move(to direction: String) {
        guard let direction = Direction(title: direction) else { return }
        let result = moveToDirectionUseCase.execute(direction: direction)
        
        switch result {
        case .success: output?.didMove()
        case .failure(let error):
            switch error {
            case .stepsLimitIsEnd:
                output?.stepsLimitDidEnd(error)
            default:
                output?.printError(error)
            }
        }
    }
    
    func pick(item: String?) {
        guard let item else { return }
        
        let result = pickItemUseCase.execute(item: item)
        
        switch result {
        case .success: output?.didPickItem()
        case .failure(let error): output?.printError(error)
        }
    }
    
    func getInventory() {
        let inventory = getInventoryUseCase.execute()
        output?.inventoryDidGet(inventory)
    }
    
    func open() {
        let result = openChestUseCase.execute()
        switch result {
        case .success:
            output?.chestDidOpen()
        case .failure(let error):
            output?.printError(error)
        }
    }
    
    func drop(item: String?) {
        guard let item else { return }
        
        let result = dropItemUseCase.execute(name: item)
        switch result {
        case let .failure(error):
            output?.printError(error)
        case .success:
            output?.itemDidDrop()
        }
    }
    
    func checkWinGame() {
        if isGameWonUseCase.execute() {
            output?.gameDidWon()
        }
    }
}
