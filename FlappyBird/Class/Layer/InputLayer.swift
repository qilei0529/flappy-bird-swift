//
//  InputLayer.swift
//  FlappyBird
//

import SpriteKit

class InputLayer: Layer {
    
    // button
    lazy var tap_box: HButton = {
        let size = self.scene.size
        let b = HButton(color: RGBA(0, 0, 0, 0), size: size)
        b.position = POS(0, 0)
        b.addTarget(event: .TouchDown, closure: {
            dispacher.trigger(action: .Fly)
        })
        return b
    }()
    
    override func render() {
        super.render()
        self.node.zPosition = 20
        self.node.position = MID(self.scene.size)
        self.node.addChild(tap_box)
    }
    
}
