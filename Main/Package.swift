// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Main",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(path: "../Presentation"),
        .package(path: "../Domain"),
        .package(path: "../Game"),
        .package(path: "../Common")
    ],
    targets: [
        .executableTarget(
            name: "Main",
            dependencies: ["Presentation", "Domain", "Game", "Common"]
        ),
    ]
)
