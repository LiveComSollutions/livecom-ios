// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LiveComSDKWrapper",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "LiveComSDKWrapper",
            targets: ["LiveComSDKWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", .exact("2.32.0")),
        .package(url: "https://github.com/apple/swift-nio-extras.git", .exact("1.11.0")),
        .package(url: "https://github.com/apple/swift-nio-http2.git", .exact("1.19.2")),
        .package(url: "https://github.com/apple/swift-nio-transport-services.git", .exact("1.12.0")),
        .package(url: "https://github.com/segmentio/analytics-ios", .exact("4.1.6")),
        .package(url: "https://github.com/stripe/stripe-ios", .exact("22.8.4")),
    ],
    targets: [
        .binaryTarget(
            name: "LiveComSDK",
            url: "https://customers.livecom.tech/ios/1.0.1/LiveComSDK.xcframework.zip",
            checksum: "7ecf11ae15381e731891c6baf4762f16a3a073f7bbda7c99278be9eb1a13c54d"
        ),
        .target(
            name: "LiveComSDKWrapper",
            dependencies: [
                .target(name: "LiveComSDK"),
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOExtras", package: "swift-nio-extras"),
                .product(name: "NIOHTTP2", package: "swift-nio-http2"),
                .product(name: "NIOTransportServices", package: "swift-nio-transport-services"),
                .product(name: "Segment", package: "analytics-ios"),
                .product(name: "StripeApplePay", package: "stripe-ios")
            ],
            resources: [.copy("Resources/LiveComSDKBundle.bundle")]
        )
    ]
)
