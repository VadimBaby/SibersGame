//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

import Common

public protocol FieldGeneratorProtocol: AnyObject {
    func arragingItems(in field: [[Room]], startCoordinate: Coordinate, needToPlaceItems: Set<Item>) -> [[Room]]
    func generateField() -> [[Room]]
}
