//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

public protocol ConfigProvider: AnyObject {
    func getConfig() -> Config
}
