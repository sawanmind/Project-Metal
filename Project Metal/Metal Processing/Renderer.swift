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
   
    var scene:Scene?
    
    
    init(device:MTLDevice) {
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        super.init()
        buildPipelineState()
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
       
        
        
        guard let commandBuffer = commandQueue?.makeCommandBuffer(),
            let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else{return}
        commandEncoder.setRenderPipelineState(pipelineState)
        
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        scene?.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        
        commandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
    
}

