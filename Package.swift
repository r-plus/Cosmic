// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "Cosmic",

  products: [
    .library(name: "Cosmic", targets: [ "Cosmic" ])
  ],

  dependencies: [
		.package(url: "https://github.com/IBM-Swift/BlueSocket", from: "1.0.0")
	],

  targets: [
    .target(
      name: "Cosmic",
      dependencies: [
        "Socket"
      ]
    ),
    .testTarget(
      name: "CosmicTests",
      dependencies: [ "Cosmic" ]
    )
  ],

  swiftLanguageVersions: [ .v4_2, .v5 ]
)
