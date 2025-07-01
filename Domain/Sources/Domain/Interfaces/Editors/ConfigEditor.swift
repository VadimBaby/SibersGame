//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

public protocol ConfigEditor: AnyObject {
    func changeConfig(_ config: Config)
}
