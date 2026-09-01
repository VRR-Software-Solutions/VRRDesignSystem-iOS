// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VRRDesignSystem",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "VRRDesignSystem",
            targets: ["VRRDesignSystem"]
        ),
    ],
    targets: [
        .target(
            name: "VRRDesignSystem",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "VRRDesignSystemTests",
            dependencies: ["VRRDesignSystem"]
        ),
    ]
)
