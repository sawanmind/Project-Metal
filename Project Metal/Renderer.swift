//
//  Renderer.swift
//  Project Metal
//
//  Created by Sawan Kumar on 17/10/18.
//  Copyright © 2018 Genisys. All rights reserved.
//

import Foundation
import MetalKit

class Renderer :NSObject {
    //MARK: Metal Device
    let device:MTLDevice
    //MARK: Command Queue
    let commandQueue:MTLCommandQueue?
    
    var pipelineState:MTLRenderPipelineState?
    var vertexBuffer:MTLBuffer?
    
  
    var vertices:[Float] =   [
         0,  0.5, 0,
        -0.8, -0.5, 0,
         0.8, -0.5, 0
    ]
        
    
    
    init(device:MTLDevice) {
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        super.init()
        buildBuffer()
        buildPipelineState()
    }
    
    fileprivate func buildBuffer(){
        vertexBuffer = device.makeBuffer(bytes: vertices,
                                         length: vertices.count * MemoryLayout<Float>.size,
                                         options: [])
    }
    
    
    fileprivate func buildPipelineState(){
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "fragment_shader")
        
        let pipelineDescripter = MTLRenderPipelineDescriptor()
        pipelineDescripter.vertexFunction = vertexFunction
        pipelineDescripter.fragmentFunction = fragmentFunction
        pipelineDescripter.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescripter)
        } catch {
            print("Error in buildPipelineState function: \(error.localizedDescription)")
        }
    }
}




extension Renderer : MTKViewDelegate {
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
            let pipelineState = pipelineState,
            let descriptor = view.currentRenderPassDescriptor else {return}
        let commandBuffer = commandQueue?.makeCommandBuffer()
        
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
        commandEncoder?.setRenderPipelineState(pipelineState)
        commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        commandEncoder?.endEncoding()
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
    
}

