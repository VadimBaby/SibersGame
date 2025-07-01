//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

protocol MenuInteractorOutput: AnyObject {
    
}

protocol MenuInteractorInput: AnyObject {
    var output: MenuInteractorOutput? { get set }
}

final class MenuInteractor: MenuInteractorInput {
    weak var output: MenuInteractorOutput?
}
