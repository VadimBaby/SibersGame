//
//  File.swift
//  Domain
//
//  Created by Вадим Мартыненко on 30.06.2025.
//

import Foundation

public final class Key: Item {
    public init() {
        super.init(id: .init(), name: "key", canPick: true)
    }
}
