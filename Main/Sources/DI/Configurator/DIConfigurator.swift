//
//  File.swift
//  Main
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

import Presentation
import Game
import Domain

protocol Assembly: AnyObject {
    func assemble(container: Registration)
}

final class DIConfigurator {
    static func configure(with assemblies: [Assembly]) -> Resolver {
        let container = DIContainer(defaultObjectScope: .container)
        
        for assembly in assemblies {
            assembly.assemble(container: container)
        }
        
        return container
    }
}

