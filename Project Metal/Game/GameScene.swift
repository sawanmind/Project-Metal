//
//  GameScene.swift
//  Project Metal
//
//  Created by Sawan Kumar on 18/10/18.
//  Copyright © 2018 Genisys. All rights reserved.
//

import MetalKit

class GameScene:Scene {
    var quad:Plane
    
    override init(device: MTLDevice, size: CGSize) {
        quad = Plane(device: device)
        super.init(device: device, size: size)
        add(childNode: quad)
    }
}
