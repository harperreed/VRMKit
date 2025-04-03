//
//  ContentView.swift
//  MacExample
//
//  Created with Claude Code
//

import SwiftUI
import SceneKit
import VRMKit
import VRMSceneKit
import AppKit

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            SceneKitView(scene: viewModel.scene, delegate: viewModel)
                .frame(minWidth: 400, minHeight: 300)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Blend Shapes")
                        .font(.headline)
                    
                    HStack {
                        Text("Joy")
                        Slider(value: $viewModel.joyValue, in: 0...1)
                            .frame(width: 200)
                    }
                    
                    HStack {
                        Text("Angry")
                        Slider(value: $viewModel.angryValue, in: 0...1)
                            .frame(width: 200)
                    }
                    
                    HStack {
                        Text("><")
                        Slider(value: $viewModel.customValue, in: 0...1)
                            .frame(width: 200)
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Humanoid Control")
                        .font(.headline)
                    
                    HStack {
                        Text("Neck Rotation")
                        Slider(value: $viewModel.neckRotation, in: -45...45)
                            .frame(width: 200)
                    }
                    
                    HStack {
                        Text("Shoulder Rotation")
                        Slider(value: $viewModel.shoulderRotation, in: -45...45)
                            .frame(width: 200)
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

// SceneKit View Wrapper for SwiftUI
struct SceneKitView: NSViewRepresentable {
    let scene: SCNScene?
    let delegate: SCNSceneRendererDelegate?
    
    init(scene: SCNScene?, delegate: SCNSceneRendererDelegate? = nil) {
        self.scene = scene
        self.delegate = delegate
    }
    
    func makeNSView(context: Context) -> SCNView {
        let view = SCNView()
        view.scene = scene
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        view.showsStatistics = true
        view.backgroundColor = .black
        view.delegate = delegate
        return view
    }
    
    func updateNSView(_ nsView: SCNView, context: Context) {
        // Updates happen via the delegate
    }
}

#Preview {
    ContentView()
}
