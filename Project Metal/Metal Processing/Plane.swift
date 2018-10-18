//
//  Plane.swift
//  Project Metal
//
//  Created by Sawan Kumar on 18/10/18.
//  Copyright © 2018 Genisys. All rights reserved.
//

import MetalKit

class Plane: Node {
    var vertexBuffer:MTLBuffer?
    var indexBuffer:MTLBuffer?
    
    
    var vertices:[Float] =   [
        -1,   1,  0, // v0
        -1,  -1,  0, // v1
        1,  -1,  0, // v2
        1,   1,  0, // v3
    ]
    
    var indices:[UInt16] = [
        0, 1, 2,
        2, 3, 0
    ]
    
    struct Constants {
        var animatedBy:Float = 0.0
    }
    
    var constants = Constants()
    var time:Float = 0
    
    fileprivate func buildBuffer(device:MTLDevice){
        vertexBuffer = device.makeBuffer(bytes: vertices,
                                         length: vertices.count * MemoryLayout<Float>.size,
                                         options: [])
        
        indexBuffer = device.makeBuffer(bytes: indices,
                                        length: indices.count * MemoryLayout<UInt16>.size,
                                        options: [])
    }
    
    
    init(device:MTLDevice) {
        super.init()
        buildBuffer(device: device)
    }
    
    fileprivate func animatingView(_ deltaTime: Float) {
        time += deltaTime
        
        let animatedBy = abs(sin(time) / 2 + 0.5)
        constants.animatedBy = animatedBy
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        super.render(commandEncoder: commandEncoder, deltaTime:deltaTime)
        guard let index = indexBuffer else {return}
        
        animatingView(deltaTime)
        
       
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        commandEncoder.setVertexBytes(&constants, length: MemoryLayout<Constants>.stride, index: 1)
        
        commandEncoder.drawIndexedPrimitives(type: .triangle,
                                              indexCount: indices.count,
                                              indexType: .uint16,
                                              indexBuffer: index,
                                              indexBufferOffset: 0)
    }
}
