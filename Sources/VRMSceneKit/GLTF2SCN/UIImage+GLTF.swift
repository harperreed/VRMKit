//
//  UIImage+GLTF.swift
//  VRMSceneKit
//
//  Created by Tatsuya Tanaka on 20180911.
//  Copyright © 2018年 tattn. All rights reserved.
//

import VRMKit
import Foundation

#if canImport(UIKit)
import UIKit
public typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias PlatformImage = NSImage
#endif

#if canImport(UIKit)
// iOS, tvOS, etc.
extension UIImage {
    convenience init(image: GLTF.Image, relativeTo rootDirectory: URL?, loader: VRMSceneLoader) throws {
        let data: Data
        if let uri = image.uri {
            data = try Data(gltfUrlString: uri, relativeTo: rootDirectory)
        } else if let bufferViewIndex = image.bufferView {
            data = try loader.bufferView(withBufferViewIndex: bufferViewIndex).bufferView
        } else {
            throw VRMError._dataInconsistent("failed to load images")
        }
        self.init(cgImage: try UIImage(data: data)?.cgImage ??? ._dataInconsistent("failed to load image"))
    }
}
#elseif canImport(AppKit)
// macOS
extension NSImage {
    convenience init(image: GLTF.Image, relativeTo rootDirectory: URL?, loader: VRMSceneLoader) throws {
        let data: Data
        if let uri = image.uri {
            data = try Data(gltfUrlString: uri, relativeTo: rootDirectory)
        } else if let bufferViewIndex = image.bufferView {
            data = try loader.bufferView(withBufferViewIndex: bufferViewIndex).bufferView
        } else {
            throw VRMError._dataInconsistent("failed to load images")
        }
        
        if let nsImage = NSImage(data: data) {
            self.init(cgImage: nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil)!, size: nsImage.size)
        } else {
            throw VRMError._dataInconsistent("failed to load image")
        }
    }
    
    var cgImage: CGImage? {
        guard let imageData = self.tiffRepresentation else { return nil }
        guard let sourceData = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        return CGImageSourceCreateImageAtIndex(sourceData, 0, nil)
    }
}
#endif