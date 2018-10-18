//
//  Node.swift
//  Project Metal
//
//  Created by Sawan Kumar on 18/10/18.
//  Copyright © 2018 Genisys. All rights reserved.
//

import MetalKit

class Node {
    var name = "Untitled"
    var children:[Node] = []
    
    
    func add(childNode:Node) {
        children.append(childNode)
    }
    
    func render(commandEncoder:MTLRenderCommandEncoder, deltaTime:Float){
        children.forEach { (child) in
            child.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        }
    }
}
