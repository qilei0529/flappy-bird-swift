//
//  StartLayer.swift
//  FlappyFird
//

import SpriteKit


class Layer {
    
    let size: CGSize
    let scene: SKScene
    let node: SKNode = SKNode()
    
    
    init( scene: SKScene ) {
        self.scene = scene
        self.size = scene.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        self.scene.addChild(self.node)
    }
    
    func show() {
        if (self.node.scene == nil) {
            self.scene.addChild(self.node)
        }
    }
    
    func hide() {
        if (self.node.scene != nil) {
            self.node.removeFromParent()
        }
    }
}

class StartLayer: Layer {
    
    // button
    lazy var btn_start: LabelButton = {
        let size = SIZE( 120, 40)
        let b = LabelButton(color: RGBA(255, 255, 255, 1), size: size)
        
        b.setTitle(title: "start game " , color:.black)
        b.onPress(closure: {
            dispacher.trigger(action: .Start)
        })
        b.zPosition = 5;
        
        b.position = POS(0, 0)
        return b
    }()
    
    
    // button
    lazy var btn_pause: LabelButton = {
        let size = SIZE( 60, 40)
        let b = LabelButton(color: RGBA(255, 255, 255, 1), size: size)
        b.setTitle(title: "stop" , color:.black)
        b.onPress(closure: {
            dispacher.trigger(action: .Pause)
        })
        b.position = POS(0, -60)
        b.zPosition = 5;
        
        return b
    }()
    
    override func render() {
        super.render()
        self.node.position = MID(self.scene.size)
        self.node.zPosition = 10
        self.node.addChild(btn_start)
//        self.node.addChild(btn_pause)
    }
}
