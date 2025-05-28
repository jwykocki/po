// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "zad7",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.89.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.6.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.2.0"),
        .package(url: "https://github.com/apple/swift-distributed-tracing.git", exact: "1.1.1")
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Leaf", package: "leaf")
            ],
            path: "Sources/App",
            resources: [
                .process("../Resources/Views")
            ]
        )
    ]
)
