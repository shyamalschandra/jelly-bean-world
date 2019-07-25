// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let package = Package(
    name: "JellyBeanWorld",
    products: [
        .library(
            name: "JellyBeanWorld",
            targets: ["JellyBeanWorld"]),
    ],
    targets: [
        .target(
            name: "CJellyBeanWorld",
            path: ".", 
            sources: [
                "api/swift/Sources/CJellyBeanWorld",
                "core/jbw/simulator.cpp"],
            publicHeadersPath: "api/swift/Sources/CJellyBeanWorld",
            cxxSettings: [
                .headerSearchPath("core"),
                .headerSearchPath("core/deps"),
                .unsafeFlags([
                    "-std=c++11", "-Wall", "-Wpedantic", "-Ofast", "-DNDEBUG", 
                    "-fno-stack-protector", "-mtune=native", "-march=native",
               ]),
            ]),
        .target(
            name: "JellyBeanWorld",
            dependencies: ["CJellyBeanWorld"],
            path: "api/swift/Sources/JellyBeanWorld"),
        .target(
            name: "JellyBeanWorldExperiments",
            dependencies: ["JellyBeanWorld"],
            path: "api/swift/Sources/JellyBeanWorldExperiments"),
    ]
)
