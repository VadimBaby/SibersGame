//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

public protocol MenuPresenterOutput: AnyObject {
    func didEnterStartCommand()
}

protocol MenuPresenterInput: AnyObject {
    var output: MenuPresenterOutput? { get set }
}

final class MenuPresenter: MenuPresenterInput {
    weak var output: MenuPresenterOutput?
    
    private unowned let view: MenuViewInput
    private let interactor: MenuInteractorInput
    
    init(view: MenuViewInput, interactor: MenuInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

extension MenuPresenter: MenuViewOutput {
    func didEnterStartCommand() {
        output?.didEnterStartCommand()
    }
    
    func didEnterShowCommand(argument: String?) {
        
    }
    
    func didEnterSetCommand(argument1: String?, argument2: String?) {
        
    }
}

extension MenuPresenter: MenuInteractorOutput {
    
}
