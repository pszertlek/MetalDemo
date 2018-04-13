//
//  ViewController.swift
//  MetalDemo
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import UIKit
import MetalKit

class ViewController: UIViewController {
    
    var render: AAPLRender!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.view = MTKView(frame: self.view.bounds)
        let mtkView = self.view as! MTKView
        mtkView.enableSetNeedsDisplay = false
        mtkView.autoResizeDrawable = true
        mtkView.device = MTLCreateSystemDefaultDevice()
        guard let _ = mtkView.device else {
            print("metal is not supported on this device")
            return
        }
        render = AAPLRender(metalKitView: mtkView)
        mtkView.delegate = render
        let timer = CADisplayLink.init(target: self, selector: #selector(renderView))
        timer.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }
    
    @objc func renderView() {
//        render.mtkView(self.view as! MTKView, drawableSizeWillChange: self.view.bounds.size)

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

