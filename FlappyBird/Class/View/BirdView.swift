//
//  BirdView.swift
//  FlappyBird
//

import SpriteKit

class BirdView: SKNode , BirdDelegate {
    
    var textures: [SKTexture] = []
    
    var box: SKSpriteNode = SKSpriteNode()
    
    var scene_size: CGSize = SIZE(0,0)
    
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
    
    func fly() {
        
    }
    
    func move( to high: CGFloat ) {
        
        let mid = MID(self.scene_size)
        let y = round_move( high / 100 * mid.y)
        self.position = POS(mid.x, 75 + y )
        
    }
    
    func round_move( _ num: CGFloat) -> CGFloat {
        let n = Int(num)
        let m = Int(num + 0.5)
        let res:CGFloat = m > n ? CGFloat(n) + 0.5 : CGFloat(n)
        return res
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
