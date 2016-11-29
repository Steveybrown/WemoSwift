import PackageDescription

let package = Package(
    name: "Wemo",
    dependencies: [
        .Package(url: "https://github.com/kylef/Commander", majorVersion: 0, minor: 6)
        //.Package(url: "https://github.com/vapor/console", majorVersion: 1),
    ]
)
