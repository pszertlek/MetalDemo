//
//  OneRender.swift
//  One
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation
import MetalKit

class OneRender: NSObject,MTKViewDelegate {
    
    var commandQueue: MTLCommandQueue!
    var device: MTLDevice!
    var growing = true
    var primaryChannel = 0
    var colorChannels = [1.0,0.0,0.0,1.0]
    let dynamicColorRate = 0.015
    
    init(mtkView: MTKView) {
        device = mtkView.device
        commandQueue = device.makeCommandQueue()
    }
    
    func makeFancyColor() -> [Double] {
        
        if growing {
            let dynamicChannelIndex = (primaryChannel+1)%3
            colorChannels[dynamicChannelIndex] += dynamicColorRate
            if colorChannels[dynamicChannelIndex] >= 1.0 {
                growing = false
                primaryChannel = dynamicChannelIndex
            }
        } else {
            let dynamicChannelIndex = (primaryChannel+2)%3
            colorChannels[dynamicChannelIndex] -= dynamicColorRate
            if colorChannels[dynamicChannelIndex] <= 1.0 {
                growing = true
            }
        }
        return colorChannels
    }
    
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        let color = makeFancyColor()
        view.clearColor = MTLClearColorMake(color[0], color[1], color[2], color[3])
        guard let commandBuffer = commandQueue.makeCommandBuffer(),
        let renderDescriptor = view.currentRenderPassDescriptor else {
            return
        }
        guard let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor) else {
            return
        }
        encoder.endEncoding()
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
        
    }
    
    func draw(in view: MTKView) {
        
    }
}
