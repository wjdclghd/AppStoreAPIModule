// swift-tools-version: 5.9

//
//  Package.swift
//  AppStoreAPIModule
//
//  Created by jch on 6/26/25.
//

import PackageDescription

let package = Package(
    name: "AppStoreAPIModule",
    platforms: [
        .iOS(.v16),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "AppStoreAPIModule", targets: ["AppStoreAPIModule"])
    ],
    dependencies: [
        .package(path: "../CoreModule")
    ],
    targets: [
        .target(
            name: "AppStoreAPIModule",
            dependencies: [
                .product(name: "CoreDatabase", package: "CoreModule"),
                .product(name: "CoreNetwork", package: "CoreModule")
            ],
            path: "Sources/AppStoreAPIModule"
        ),
        .testTarget(
            name: "AppStoreAPIModuleTests",
            dependencies: ["AppStoreAPIModule"],
            path: "Tests/AppStoreAPIModuleTests"
        )
    ]
)
