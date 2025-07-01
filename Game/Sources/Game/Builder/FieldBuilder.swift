//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 29.06.2025.
//

import Domain
import Common

public final class FieldBuilder: FieldBuilderProtocol {
    private let fieldGenerator: FieldGeneratorProtocol
    private let fieldItemsProvider: FieldItemsProvider
    
    public init(
        fieldGenerator: FieldGeneratorProtocol,
        fieldItemsProvider: FieldItemsProvider
    ) {
        self.fieldGenerator = fieldGenerator
        self.fieldItemsProvider = fieldItemsProvider
    }
    
    public func createField(startCoordinate: Coordinate) -> Field {
        let items = fieldItemsProvider.getFieldItems()
        
        let field = fieldGenerator.generateField()
        let fieldWithItems = fieldGenerator.arragingItems(in: field, startCoordinate: startCoordinate, needToPlaceItems: items)
        
        return Field(value: fieldWithItems)
    }
}
