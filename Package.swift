// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "AtlasFramework",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "AtlasFramework", targets: ["AtlasFramework"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AtlasFramework",
            dependencies: [],
            path: "Atlas/Atlas"
        )
    ]
)
