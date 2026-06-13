// swift-tools-version: 5.9
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
        .library(name: "iOSUIComponents", targets: ["iOSUIComponents"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "iOSUIComponents",
            dependencies: [],
            path: "Sources/iOSUIComponents",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "iOSUIComponentsTests",
            dependencies: ["iOSUIComponents"])
    ]
)
