//
//  OneView.swift
//  One
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation
import MetalKit

class OneView: MTKView {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        device = MTLCreateSystemDefaultDevice()
        delegate = OneRender(mtkView: self)
    }
    
    override func draw(_ dirtyRect: NSRect) {
//        delegate!.mtkView(self, drawableSizeWillChange: self.bounds.size)
    }
}
