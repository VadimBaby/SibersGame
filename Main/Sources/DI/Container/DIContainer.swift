//
//  File.swift
//  Main
//
//  Created by Вадим Мартыненко on 30.06.2025.
//

import Foundation
import Presentation

final class DIContainer: Resolver, Registration {
    private var objectScopes = [String: ContainerObjectScope]()
    private var dependencies = [String: () -> Any]()
    private var instances = [String: Any]()
    private let lock = NSRecursiveLock()
    
    private let defaultObjectScope: ContainerObjectScope?
    
    init(defaultObjectScope: ContainerObjectScope? = nil) {
        self.defaultObjectScope = defaultObjectScope
    }

    @discardableResult
    func register(_ type: Any.Type, name: String? = nil, constructor: @escaping ((Resolver) -> Any)) -> RegistrationConfigurator {
        lock.lock()

        defer {
            lock.unlock()
        }
        
        let key = makeKey(type, name: name)

        dependencies[key] = {
            return constructor(self)
        }
        
        if let defaultObjectScope {
            register(type: type, in: defaultObjectScope)
        }
        
        return RegistrationConfigurator(self, type, name)
    }

    func resolve<T>(_ type: T.Type, name: String? = nil) -> T? {
        lock.lock()

        defer {
            lock.unlock()
        }

        let key = makeKey(type, name: name)

        if let instance = instances[key] {
            return instance as? T
        }

        if let ctor = dependencies[key] {
            let obj = ctor() as? T

            if let scope = objectScopes[key], scope == .container {
                instances[key] = obj
            }

            return obj
        }

        return nil
    }

    func register(type: Any.Type, name: String? = nil, in objectScope: ContainerObjectScope) {
        lock.lock()
        let key = makeKey(type, name: name)
        objectScopes[key] = objectScope
        lock.unlock()
    }
    
    func implements(type: Any.Type, types: [Any.Type]) {
        let key = makeKey(type)

        for t in types {
            let aliasKey = makeKey(t)

            dependencies[aliasKey] = dependencies[key]

            if let scope = objectScopes[key] {
                objectScopes[aliasKey] = scope
            }

            if let instance = instances[key] {
                instances[aliasKey] = instance
            }
        }
    }
}

// MARK: - Private

private extension DIContainer {
    func getClassName(_ type: Any.Type) -> String {
        if let type = type as? OptionalProtocol.Type {
            return String(describing: type.wrappedType)
        } else {
            return String(describing: type)
        }
    }
    
    func makeKey(_ type: Any.Type, name: String? = nil) -> String {
        let className = getClassName(type)
        if let name = name {
            return "\(className)_\(name)"
        }
        return className
    }
}
