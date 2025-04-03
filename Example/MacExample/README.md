# VRMKit macOS Example

This is an example macOS application that demonstrates the use of VRMKit with SceneKit on macOS.

## Features

- Loads and renders a VRM model using SceneKit
- Demonstrates the use of blend shapes (facial expressions)
- Shows how to control humanoid bones (neck, shoulders)
- Built with SwiftUI and Combine for a modern macOS application

## Requirements

- macOS 12.0+
- Xcode 14.0+
- Swift 5.7+

## Getting Started

1. Open the Example.xcodeproj in Xcode
2. Select the "MacExample" target
3. Build and run the application

## Usage

The application provides:

- A 3D view of the VRM model that can be rotated and zoomed
- Sliders to control blend shapes (Joy, Angry, etc.)
- Sliders to control neck and shoulder rotations

## Implementation Details

This example demonstrates several key aspects of using VRMKit on macOS:

- Using the PlatformImage and PlatformColor abstractions
- Handling macOS-specific SceneKit views
- Using SwiftUI for the user interface
- Using Combine for reactive updates

## Notes

The example looks for "AliciaSolid.vrm" in the app bundle. If not found, it will try to access it from the test assets directory.

## Troubleshooting

If you encounter issues:

1. Make sure you've copied the model file to the project
2. Check that the VRMKit and VRMSceneKit targets are properly linked
3. Verify that your macOS deployment target is 12.0 or higher