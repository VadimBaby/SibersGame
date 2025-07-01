//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 01.07.2025.
//

public protocol ItemParserProtocol: AnyObject {
    func parse(name: String) -> Item.Type?
}
