//
//  ViewModel.swift
//  MacExample
//
//  Created with Claude Code
//

import Foundation
import SceneKit
import VRMKit
import VRMSceneKit
import Combine
import AppKit

class ViewModel: ObservableObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    private var vrmNode: VRMNode?
    private var updateTimer: Timer?
    
    @Published var joyValue: Double = 0 {
        didSet { updateBlendShape(.preset(.joy), value: joyValue) }
    }
    
    @Published var angryValue: Double = 0 {
        didSet { updateBlendShape(.preset(.angry), value: angryValue) }
    }
    
    @Published var customValue: Double = 0 {
        didSet { updateBlendShape(.custom("><"), value: customValue) }
    }
    
    @Published var neckRotation: Double = 0 {
        didSet { updateNeckRotation() }
    }
    
    @Published var shoulderRotation: Double = 0 {
        didSet { updateShoulderRotation() }
    }
    
    init() {
        loadVRM()
        setupUpdateTimer()
    }
    
    private func loadVRM() {
        do {
            // Look for VRM file in the bundle
            guard let vrmURL = Bundle.main.url(forResource: "AliciaSolid", withExtension: "vrm") else {
                // Use the test assets if not found in the bundle
                let testAssetsURL = URL(fileURLWithPath: "/Users/harper/Public/src/2389/char/VRMKit/Tests/VRMKitTests/Assets/AliciaSolid.vrm")
                let loader = try VRMSceneLoader(url: testAssetsURL)
                scene = try loader.loadScene()
                setupScene()
                vrmNode = (scene as? VRMScene)?.vrmNode
                return
            }
            
            let loader = try VRMSceneLoader(url: vrmURL)
            scene = try loader.loadScene()
            setupScene()
            vrmNode = (scene as? VRMScene)?.vrmNode
        } catch {
            print("Error loading VRM: \(error)")
        }
    }
    
    private func setupScene() {
        guard let scene = scene else { return }
        
        // Setup camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        cameraNode.position = SCNVector3(0, 0.8, -1.6)
        cameraNode.rotation = SCNVector4(0, 1, 0, Float.pi)
        
        // Add rotation animation
        (scene as? VRMScene)?.vrmNode.runAction(SCNAction.repeatForever(SCNAction.sequence([
            SCNAction.rotateBy(x: 0, y: -0.5, z: 0, duration: 0.5),
            SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 0.5),
        ])))
    }
    
    private func setupUpdateTimer() {
        // No need for timer with delegate-based rendering
        // We'll use the SCNSceneRendererDelegate methods instead
    }
    
    // MARK: - SCNSceneRendererDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let scene = scene as? VRMScene else { return }
        scene.vrmNode.update(at: time)
    }
    
    private func updateBlendShape(_ blendShape: VRMBlendShapeKey, value: Double) {
        vrmNode?.setBlendShape(value: Float(value), for: blendShape)
    }
    
    private func updateNeckRotation() {
        vrmNode?.humanoid.node(for: .neck)?.eulerAngles = 
            SCNVector3(0, 0, Float(neckRotation) * Float.pi / 180)
    }
    
    private func updateShoulderRotation() {
        let rotation = Float(shoulderRotation) * Float.pi / 180
        vrmNode?.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3(0, 0, rotation)
        vrmNode?.humanoid.node(for: .rightShoulder)?.eulerAngles = SCNVector3(0, 0, rotation)
    }
    
    deinit {
        updateTimer?.invalidate()
    }
}