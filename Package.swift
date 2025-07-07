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
        .library(
            name: "AppStoreAPIModule",
            targets: ["AppStoreAPIModule"]
        ),
    ],
    targets: [
        .target(
            name: "AppStoreAPIModule",
            path: "Sources/AppStoreAPIModule",
            exclude: [],
            resources: [],
            publicHeadersPath: nil
        ),
        .testTarget(
            name: "AppStoreAPIModuleTests",
            dependencies: ["AppStoreAPIModule"],
            path: "Tests/AppStoreAPIModuleTests"
        )
    ]
    
//    products: [
//        .library(
//            name: "CoreNetwork",
//            targets: ["CoreNetwork"]
//        ),
//    ],
//    dependencies: [
//        .package(
//            url: "https://github.com/Alamofire/Alamofire.git",
//            .upToNextMajor(from: "5.10.2")
//        )
//    ],
//    targets: [
//        .target(
//            name: "CoreNetwork",
//            dependencies: [
//                .product(name: "Alamofire", package: "Alamofire")
//            ],
//            path: "Sources/CoreNetwork",
//            exclude: [],
//            resources: [],
//            publicHeadersPath: nil
//        ),
//        .testTarget(
//            name: "CoreNetworkTests",
//            dependencies: ["CoreNetwork"],
//            path: "Tests/CoreNetworkTests"
//        )
//    ]
)
