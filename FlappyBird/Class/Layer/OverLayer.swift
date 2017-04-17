//
//  InputLayer.swift
//  FlappyBird
//

import SpriteKit

class OverLayer: Layer {
    
    // button
    lazy var btn_start: LabelButton = {
        let size = SIZE( 120, 40)
        let b = LabelButton(color: RGBA(255, 255, 255, 1), size: size)
        
        b.setTitle(title: " Restart " , color:.black)
        b.onPress(closure: {
            dispacher.trigger(action: .ReStart)
        })
        b.zPosition = 5;
        
        b.position = POS(0, 0)
        return b
    }()
    
    
    override func render() {
        super.render()
        self.node.zPosition = 20
        self.node.position = MID(self.scene.size)
        self.node.addChild(btn_start)
    }
    
}
