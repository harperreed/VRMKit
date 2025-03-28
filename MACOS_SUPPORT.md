# VRMKit macOS Support

VRMKit now fully supports macOS platforms (macOS 12+) alongside iOS and watchOS.

## Overview

The macOS port allows you to use VRMKit in macOS applications, enabling VRM file loading, rendering, and manipulation using the same APIs that were previously available only on iOS and watchOS.

## Key Changes

1. **Platform Abstraction**
   - Added macOS as a supported platform in Package.swift
   - Created platform-agnostic typealias for UIKit/AppKit types:
     - `PlatformImage` (UIImage → NSImage)
     - `PlatformColor` (UIColor → NSColor)
     - `SKColor` (UIColor → NSColor on macOS)

2. **Image Handling**
   - Implemented macOS-specific image loading and processing
   - Added proper CGImage conversion for NSImage
   - Handled platform-specific texture creation

3. **Drawing and Rendering**
   - Updated all color references to use platform-agnostic types
   - Implemented debug gizmo drawing for macOS
   - Ensured NSValue compatibility across platforms

## Usage

No API changes are required for existing code. The library automatically selects the appropriate implementation based on the platform.

### Swift Package Manager

Update your package dependencies to use the latest version of VRMKit:

```swift
.package(url: "https://github.com/your-org/VRMKit.git", from: "x.y.z")
```

### Project Setup

For new projects, ensure you have the correct dependencies:

```swift
import VRMKit        // Core VRM parsing
import VRMSceneKit   // SceneKit integration
```

## Example

Loading a VRM file works the same way on all platforms:

```swift
import VRMKit
import VRMSceneKit

// Load a VRM file
let url = URL(fileURLWithPath: "/path/to/model.vrm")
let loader = try VRMSceneLoader(url: url)
let scene = try loader.loadScene()

// On macOS, add to SCNView
let scnView = SCNView(frame: view.bounds)
scnView.scene = scene
view.addSubview(scnView)
```

## Compatibility Notes

- The core rendering uses SceneKit, which is available on all Apple platforms
- Some visual differences may occur due to different color management between platforms
- Performance characteristics may vary between macOS and iOS

## Known Issues

- Some advanced shader features might render differently on macOS
- The example app hasn't been ported to macOS yet (coming soon)

## Contributing

If you encounter any platform-specific issues, please submit an issue with details about:
- macOS version
- VRMKit version
- Sample code or VRM file that demonstrates the issue