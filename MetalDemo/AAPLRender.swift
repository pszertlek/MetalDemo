//
//  AAPLRender.swift
//  MetalDemo
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation
import MetalKit

class AAPLRender: NSObject, MTKViewDelegate {
    
    var device: MTLDevice
    var commandQueue: MTLCommandQueue
    var growing = true
    var primaryChannel = 0
    var colorChannels = [1.0,0.0,0.0,1.0]
    let dynamicColorRate = 0.015

    
    init(metalKitView: MTKView) {
        device = metalKitView.device!
        commandQueue = device.makeCommandQueue()!
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
        let color = self.makeFancyColor()

        view.clearColor = MTLClearColorMake(color[0], color[1], color[2], color[3])
        guard let commandBuffer = commandQueue.makeCommandBuffer() else  {
            return
        }
        commandBuffer.label = "MyCommand"
        let renderPassDescriptor = view.currentRenderPassDescriptor
        if renderPassDescriptor != nil {
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor!)
            renderEncoder?.endEncoding()
            commandBuffer.present(view.currentDrawable!)
            commandBuffer.commit()
        }
    }
    
    func draw(in view: MTKView) {
        
    }
    
}
