// swift-tools-version: 5.9

//
//  Package.swift
//  CoreNetwork
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
                "CoreModule"
            ],
            path: "Sources/AppStoreAPIModule",
            exclude: [],
            resources: [],
            publicHeadersPath: nil
        ),
//        .testTarget(
//            name: "AppStoreAPIModuleTests",
//            dependencies: ["AppStoreAPIModule"],
//            path: "Tests/AppStoreAPIModuleTests"
//        )
    ]
)
