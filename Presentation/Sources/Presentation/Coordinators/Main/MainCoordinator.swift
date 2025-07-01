//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

import MyCommon

private struct Constants {
    static let COMMAND_FOR_EXIT = "exit"
}

public final class MainCoordinator {
    private let resolver: Resolver
    
    public typealias MenuViewAssembly = (_ coordinator: MenuPresenterOutput, _ resolver: Resolver) -> MainCoordinatorViewProtocol
    public typealias GameViewAssembly = (_ coordinator: GamePresenterOutput, _ resolver: Resolver) -> MainCoordinatorViewProtocol
    
    private let menuViewAssembly: MenuViewAssembly
    private let gameViewAssembly: GameViewAssembly
    
    private var menuView: MainCoordinatorViewProtocol?
    private var gameView: MainCoordinatorViewProtocol?
    
    public init(
        menuViewAssembly: @escaping MenuViewAssembly,
        gameViewAssembly: @escaping GameViewAssembly,
        resolver: Resolver
    ) {
        self.menuViewAssembly = menuViewAssembly
        self.gameViewAssembly = gameViewAssembly
        self.resolver = resolver
    }
    
    private var mainView: MainCoordinatorViewProtocol?
    
    public func start() {
        presentMenu()
        startHandlingUserMessages()
    }
}

// MARK: - Presents

private extension MainCoordinator {
    func presentMenu() {
        if menuView.isNil { menuView = menuViewAssembly(self, resolver) }
        setAsMainView(menuView)
    }
    
    func presentGame() {
        if gameView.isNil { gameView = gameViewAssembly(self, resolver) }
        setAsMainView(gameView)
    }
}

// MARK: - Helpers

private extension MainCoordinator {
    func setAsMainView(_ view: MainCoordinatorViewProtocol?) {
        mainView = view
        mainView?.viewDidAppear()
    }
    
    func startHandlingUserMessages() {
        while true {
            let message = readLine() ?? .empty
            let trimMessage = message.trimmingCharacters(in: .whitespaces)
            if trimMessage == Constants.COMMAND_FOR_EXIT { break }
            mainView?.didEnterString(trimMessage)
        }
    }
}

// MARK: - MenuPresenterOutput

extension MainCoordinator: MenuPresenterOutput {
    public func didEnterStartCommand() {
        presentGame()
    }
}

// MARK: - GamePresenterOutput

extension MainCoordinator: GamePresenterOutput {
    public func gameDidEnd() {
        presentMenu()
    }
}
