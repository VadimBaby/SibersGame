//
//  File.swift
//  Main
//
//  Created by Вадим Мартыненко on 30.06.2025.
//

import Presentation

protocol Registration: AnyObject {
    @discardableResult func register(_ type: Any.Type, name: String?, constructor: @escaping ((Resolver) -> Any)) -> RegistrationConfigurator
}

extension Registration {
    @discardableResult func register(_ type: Any.Type, name: String? = nil, constructor: @escaping ((Resolver) -> Any)) -> RegistrationConfigurator {
        register(type, name: name, constructor: constructor)
    }
}
