import Presentation

// MARK: - DI
let resolver = DIConfigurator.configure(with: [DataAssembly(), DomainAssembly()])

// MARK: - Main Coordinator
let mainCoordinator = MainCoordinatorAssembly.assembly(resolver: resolver)
mainCoordinator.start()
