//
//  BirdView.swift
//  FlappyBird
//

import SpriteKit

class BirdView: SKNode , BirdDelegate {
    
    var textures: [SKTexture] = []
    
    var box: SKSpriteNode = SKSpriteNode()
    
    var scene_size: CGSize = SIZE(0,0)
    
    var high: CGFloat = 0
    var rotate: CGFloat = 0
    
    override init() {
        super.init()
        self.render()
    }
    
    func render() {
        
        let m :[String] = ["bird-1","bird-2", "bird-3"]
        
        m.forEach { (name) in
            let t = SKTexture(imageNamed: name)
            self.textures.append(t)
        }
        self.addChild(self.box)
        self.animate()
    }
    
    func animate() {
        self.box.size = SIZE(45, 45)
        let c = SKAction.animate(with: self.textures, timePerFrame: 0.16, resize: false, restore: false)
        let r = SKAction.repeatForever(c)
        self.box.run(r, withKey: "action")
    }
    
    func rise( to rotate: CGFloat ) {
        // 1 ~ -1
        
        let r = ROUND( rotate )
        
        if ( self.rotate != r) {
            self.rotate = r
            let PI: CGFloat = 3.14
            let rot = r * PI / 180
            self.box.zRotation = rot
        }
        
    }
    
    func over() {
        
        let t = [self.textures[0]]
        let c = SKAction.animate(with: t, timePerFrame: 0.16, resize: false, restore: false)
        self.box.run(c, withKey: "action")
    }
    
    func move( to high: CGFloat ) {
        
        let mid = MID(self.scene_size)
        let y = ROUND( high / 100 * mid.y)
        
        let h = 75 + y
        
        if ( h !=  self.high) {
            self.high = h
            self.position = POS(mid.x, h )
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
