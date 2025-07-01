//
//  File.swift
//  Main
//
//  Created by Вадим Мартыненко on 30.06.2025.
//

protocol OptionalProtocol {
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { return Wrapped.self }
}
