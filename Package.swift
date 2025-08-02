// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iOSUIComponents",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "iOSUIComponents",
            targets: ["iOSUIComponents"]),
        .library(
            name: "ButtonComponents",
            targets: ["ButtonComponents"]),
        .library(
            name: "CardComponents",
            targets: ["CardComponents"]),
        .library(
            name: "InputComponents",
            targets: ["InputComponents"]),
        .library(
            name: "NavigationComponents",
            targets: ["NavigationComponents"]),
        .library(
            name: "ListComponents",
            targets: ["ListComponents"]),
        .library(
            name: "ModalComponents",
            targets: ["ModalComponents"])
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.9.1"),
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.54.0")
    ],
    targets: [
        .target(
            name: "iOSUIComponents",
            dependencies: [
                "ButtonComponents",
                "CardComponents",
                "InputComponents",
                "NavigationComponents",
                "ListComponents",
                "ModalComponents"
            ]),
        .target(
            name: "ButtonComponents",
            dependencies: []),
        .target(
            name: "CardComponents",
            dependencies: []),
        .target(
            name: "InputComponents",
            dependencies: []),
        .target(
            name: "NavigationComponents",
            dependencies: []),
        .target(
            name: "ListComponents",
            dependencies: []),
        .target(
            name: "ModalComponents",
            dependencies: []),
        .testTarget(
            name: "iOSUIComponentsTests",
            dependencies: ["iOSUIComponents"])
    ]
) 