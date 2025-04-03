# Adding MacExample to the Xcode Project

To add the macOS example to your Xcode project, follow these steps:

## 1. Open the existing project

Open the `Example.xcodeproj` file in Xcode.

## 2. Add a new macOS target

1. Click on the project file in the Project Navigator
2. Click the + button at the bottom of the Targets list
3. Select "macOS" tab
4. Choose "App" template and click Next
5. Configure the new target:
   - Product Name: MacExample
   - Team: Select your team
   - Organization Identifier: (same as the existing project)
   - Bundle Identifier: (automatically generated)
   - Language: Swift
   - Interface: SwiftUI (or Storyboard if needed)
   - Leave the checkboxes as default
6. Click Finish

## 3. Delete the auto-generated files

You can delete the auto-generated files that Xcode creates since you'll use the files we've prepared.

## 4. Add our example files to the project

1. Right-click on the MacExample target in the Project Navigator
2. Select "Add Files to 'MacExample'..."
3. Navigate to the MacExample directory and select all the following files:
   - AppDelegate.swift
   - ContentView.swift
   - ViewModel.swift
   - Info.plist
   - Assets.xcassets (folder)
   - Base.lproj (folder with Main.storyboard)
   - AliciaSolid.vrm (model file)
   - MacExample.entitlements
   - README.md (optional)
4. Make sure "Copy items if needed" is checked
5. Make sure the target is set to MacExample
6. Click Add

## 5. Configure the target build settings

1. Select the MacExample target in the Project Navigator
2. Go to the Build Settings tab
3. Ensure macOS Deployment Target is set to 12.0 or higher
4. Under Packaging, make sure Info.plist File is set to `MacExample/Info.plist`

## 6. Link with VRMKit frameworks

1. Select the MacExample target in the Project Navigator
2. Go to the General tab
3. Under Frameworks, Libraries, and Embedded Content, click the + button
4. Add both VRMKit and VRMSceneKit frameworks

## 7. Add model to the build phases

1. Select the MacExample target in the Project Navigator
2. Go to the Build Phases tab
3. Expand "Copy Bundle Resources"
4. Ensure AliciaSolid.vrm is listed there (add it if not)

## 8. Run the app

1. Select the MacExample scheme from the scheme selector
2. Choose a macOS simulator or your Mac as the run destination
3. Click Run

## Troubleshooting

If you encounter build errors:

1. Check that all files are properly added to the target
2. Verify Info.plist paths are correct
3. Ensure the frameworks are properly linked
4. Make sure the model file is included in the bundle

If the VRM model doesn't appear:
- Check the console for file loading errors
- Verify the file path in ViewModel.swift
- Ensure the VRM file is included in the Copy Bundle Resources phase