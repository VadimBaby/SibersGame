//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

import Common

public protocol FieldBuilderProtocol: AnyObject {
    func createField(startCoordinate: Coordinate) -> Field
}
