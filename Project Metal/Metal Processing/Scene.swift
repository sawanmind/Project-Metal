//
//  Scene.swift
//  Project Metal
//
//  Created by Sawan Kumar on 18/10/18.
//  Copyright © 2018 Genisys. All rights reserved.
//

import MetalKit

class Scene:Node {
    var device:MTLDevice
    var size: CGSize
    
    init(device:MTLDevice, size:CGSize) {
        self.device = device
        self.size = size
        super.init()
    }
}
