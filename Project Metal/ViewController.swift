//
//  ViewController.swift
//  Project Metal
//
//  Created by Sawan Kumar on 17/10/18.
//  Copyright © 2018 Genisys. All rights reserved.
//

import UIKit
import MetalKit

class ViewController: UIViewController {

  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            setupMetalView()
    }
  
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        metalView.frame = self.view.bounds
    }

    fileprivate func setupMetalView(){
        self.view.addSubview(metalView)
        metalView.device = MTLCreateSystemDefaultDevice()
        
        guard let device = metalView.device else {
            fatalError("Device cannot be created. Run on physical device")
        }
        
        renderer = Renderer(device: device)
        metalView.delegate = renderer
    }
    
    //MARK: Metal View
    var metalView:MTKView = {
       let instance = MTKView(frame: UIScreen.main.bounds)
       instance.clearColor = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
       return instance
    }()
    
    //MARK: Renderer
    var renderer:Renderer?

}

