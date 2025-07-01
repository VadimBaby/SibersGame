//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

public protocol ItemFactoryProtocol: AnyObject {
    func createKeyItem() -> Key
    func createChestItem() -> Chest
    func createGrailItem() -> Grail
}
