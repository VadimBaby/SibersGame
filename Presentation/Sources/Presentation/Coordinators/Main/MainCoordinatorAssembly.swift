//
//  File.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 26.06.2025.
//

public final class MainCoordinatorAssembly {
    public static func assembly(resolver: Resolver) -> MainCoordinator {
        return MainCoordinator(
            menuViewAssembly: { MenuAssembly.assembly(coordinator: $0, resolver: $1) },
            gameViewAssembly: { GameAssembly.assembly(coordinator: $0, resolver: $1) },
            resolver: resolver
        )
    }
}
