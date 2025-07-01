//
//  File.swift
//  Data
//
//  Created by Вадим Мартыненко on 27.06.2025.
//

import Foundation
import Common
import Domain
import MyCommon

public final class FieldGenerator: FieldGeneratorProtocol {
    private let configProvider: ConfigProvider
    private let spawnerProvider: SpawnerProvider
    
    public init(configProvider: ConfigProvider, spawnerProvider: SpawnerProvider) {
        self.configProvider = configProvider
        self.spawnerProvider = spawnerProvider
    }
    
    private var config: Config {
        configProvider.getConfig()
    }
    
    private var itemSpawner: SpawnStrategyProtocol {
        spawnerProvider.getSpawner()
    }
    
    public func generateField() -> [[Room]] {
        let height = config.height
        let width = config.width
        
        var field: [[Room]] = []
        
        for y in 0...height.minusOne {
            for x in 0...width.minusOne {
                let directions = getAvaliableDirections(x: x, y: y)
                let coordinate = Coordinate(x: x, y: y)
                
                let room = Room(coordinate: coordinate, items: [], avaliableDirections: directions)
                appendRoom(to: &field, room: room)
            }
        }
        
        return field
    }
    
    public func arragingItems(
        in field: [[Room]],
        startCoordinate: Coordinate,
        needToPlaceItems: Set<Item>
    ) -> [[Room]] {
        var updatedField = field
        
        stepAndPlaceItem(field: &updatedField, currentCoordinate: startCoordinate, stepsLimit: config.stepsLimit, needToPlaceItems: needToPlaceItems, stepsSinceLastSpawn: nil)
        
        return updatedField
    }
}

// MARK: - Private Method

private extension FieldGenerator {
    func getAvaliableDirections(x: Int, y: Int) -> Set<Direction> {
        var directions = Direction.getAll()
    
        if x == 0 { directions.remove(.west) }
        if x == config.width.minusOne { directions.remove(.east) }
        
        if y == 0 { directions.remove(.north) }
        if y == config.height.minusOne { directions.remove(.south) }
        
        return directions
    }
    
    func stepAndPlaceItem(
        field: inout [[Room]],
        currentCoordinate: Coordinate,
        stepsLimit: Int,
        needToPlaceItems: Set<Item>,
        stepsSinceLastSpawn: Int?
    ) {
        guard stepsLimit > 0 && needToPlaceItems.isNotEmpty else { return }
        
        let (nextX, nextY) = nextCoordinate(from: currentCoordinate)
        
        guard let nextX, let nextY else {
            stepAndPlaceItem(field: &field, currentCoordinate: currentCoordinate, stepsLimit: stepsLimit, needToPlaceItems: needToPlaceItems, stepsSinceLastSpawn: stepsSinceLastSpawn)
            return
        }
        
        let newCoordinates = Coordinate(x: nextX, y: nextY)
        
        var updatedStepsSinceLastSpawn = stepsSinceLastSpawn
        var updatedItemsToPlace = needToPlaceItems
        
        if let randomItem = needToPlaceItems.randomElement(),
           itemSpawner.spawnDecision(at: stepsLimit, stepsSinceLastSpawn: stepsSinceLastSpawn) {
            
            updatedItemsToPlace.remove(randomItem)
            
            place(item: randomItem, at: newCoordinates, in: &field)
            
            updatedStepsSinceLastSpawn = 0
        } else if let stepsSinceLastSpawn {
            updatedStepsSinceLastSpawn = stepsSinceLastSpawn + 1
        }
        
        stepAndPlaceItem(field: &field, currentCoordinate: newCoordinates, stepsLimit: stepsLimit - 1, needToPlaceItems: updatedItemsToPlace, stepsSinceLastSpawn: updatedStepsSinceLastSpawn)
    }
}

// MARK: - Helpers

private extension FieldGenerator {
    func nextCoordinate(from point: Coordinate) -> (Int?, Int?) {
        let direction = Direction.random()
        let newCoordinate = point.move(direction: direction)

        let x = newCoordinate.x
        let y = newCoordinate.y
        
        guard (0..<config.width).contains(x) && (0..<config.height).contains(y) else {
            return (nil, nil)
        }

        return (x, y)
    }

    func place(item: Item, at point: Coordinate, in field: inout [[Room]]) {
        let x = Int(point.x)
        let y = Int(point.y)
        
        let room = field[y][x]
        var items = room.items
        items.insert(item)

        field[y][x] = room.set(items: items)
    }
    
    func appendRoom(to field: inout [[Room]], room: Room) {
        let y = room.coordinate.y
        
        if field.hasElement(index: y) {
            field[y].append(room)
        } else {
            field.append([room])
        }
    }
}
