//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

final class MenuAssembly {
    static func assembly(coordinator: MenuPresenterOutput, resolver: Resolver) -> MainCoordinatorViewProtocol {
        let view = MenuView()
        let interactor = MenuInteractor()
        let presenter = MenuPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = coordinator
        
        return view
    }
}
