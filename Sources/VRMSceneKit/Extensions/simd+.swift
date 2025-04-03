//
//  simd+.swift
//  VRMSceneKit
//
//  Created by Tomoya Hirano on 2020/02/16.
//  Copyright © 2020 tattn. All rights reserved.
//

import simd
import SceneKit

extension SIMD3 where Scalar == Float {
    var normalized: SIMD3 {
        simd_normalize(self)
    }
    
    var length: Scalar {
        simd_length(self)
    }
    
    var length_squared: Scalar {
        simd_length_squared(self)
    }
}

extension simd_float4x4 {
    func multiplyPoint(_ v: SIMD3<Float>) -> SIMD3<Float> {
        let scn = SCNMatrix4(self)
        var vector3: SIMD3<Float> = SIMD3<Float>()
        
        // Breaking up the expressions to help the type checker
        // Convert CGFloat to Float for all operations
        let m11 = Float(scn.m11)
        let m12 = Float(scn.m12)
        let m13 = Float(scn.m13)
        let m14 = Float(scn.m14)
        let m21 = Float(scn.m21)
        let m22 = Float(scn.m22)
        let m23 = Float(scn.m23)
        let m24 = Float(scn.m24)
        let m31 = Float(scn.m31)
        let m32 = Float(scn.m32)
        let m33 = Float(scn.m33)
        let m34 = Float(scn.m34)
        let m41 = Float(scn.m41)
        let m42 = Float(scn.m42)
        let m43 = Float(scn.m43)
        let m44 = Float(scn.m44)
        
        // Row 1
        let x1 = m11 * v.x
        let y1 = m21 * v.y
        let z1 = m31 * v.z
        vector3.x = (x1 + y1 + z1) + m41
        
        // Row 2
        let x2 = m12 * v.x
        let y2 = m22 * v.y
        let z2 = m32 * v.z
        vector3.y = (x2 + y2 + z2) + m42
        
        // Row 3
        let x3 = m13 * v.x
        let y3 = m23 * v.y
        let z3 = m33 * v.z
        vector3.z = (x3 + y3 + z3) + m43
        
        // W component for perspective division
        let w1 = m14 * v.x
        let w2 = m24 * v.y
        let w3 = m34 * v.z
        let w = (w1 + w2 + w3) + m44
        let num: Float = 1.0 / w
        
        vector3.x *= num
        vector3.y *= num
        vector3.z *= num
        return vector3
    }
}

extension simd_quatf {
    static func * (_ left: simd_quatf, _ right: SIMD3<Float>) -> SIMD3<Float> {
        simd_act(left, right)
    }
}
var quart_identity_float = simd_quatf(matrix_identity_float4x4)
