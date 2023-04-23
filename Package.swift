// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "crashing-cluster",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-distributed-actors", branch: "main"),
        .package(url: "https://github.com/swift-server/swift-service-lifecycle.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "CrashingCluster",
            dependencies: [
                .product(name: "DistributedCluster", package: "swift-distributed-actors"),
                .product(name: "Lifecycle", package: "swift-service-lifecycle")
            ]
        ),
        .testTarget(
            name: "CrashingClusterTests",
            dependencies: ["CrashingCluster"]),
    ]
)
