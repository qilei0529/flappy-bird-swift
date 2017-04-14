//
//  CloneView.swift
//  FlappyBird
//

import SpriteKit


class CloneView: SKNode {
    
    var size: CGSize
    var box_count: Int = 0
    var box_num: Int = 1
    var box_stack: [SKSpriteNode] = []
    var box_texture: SKTexture
    var box_pos: CGPoint
    
    var box_size: CGSize = SIZE(10, 10)
    
    init( name: String , size: CGSize , pos: CGPoint = POS(0,0)) {
        
        self.size = size
        self.box_texture = SKTexture(imageNamed: name)
        self.box_size = self.box_texture.size()
        self.box_pos = pos
        super.init()
        
        self.render_box()
        
    }
    
    func render_box() {
        let size = self.size
        let s = self.box_size
        
        let len:CGFloat = size.width / s.width
        
        var n = 1
        
        if ( len > 1 ) {
            n = Int(len)
        }
        
        if ( len > 2 ) {
            n += 1
        }
        
        //        n = n - 1
        
        for _ in 0...n {
            let box = self.create()
            self.addChild(box)
        }
        
        
        self.box_num = self.box_count
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func create() -> SKSpriteNode {
        
        let t = self.box_texture
        let s = self.box_size
        let b = SKSpriteNode(texture: t, size: s)
        
        let x: CGFloat = CGFloat(self.box_count) * s.width
        
        let p = self.box_pos
        b.position = POS( p.x + x, p.y + s.height / 2 )
        
        
        self.box_count += 1
        self.box_stack.append(b)
        
        return b
    }
    
    
    
    func check_side() {
        let p = self.position
        
        let s = self.box_size
        
        let max = CGFloat(self.box_count - self.box_num) * s.width
        
        if -p.x - max > 1 {
            
            let b = self.create()
            self.addChild(b)
            
            if ( box_stack.count > self.box_num + 1 ) {
                let first = self.box_stack.removeFirst()
                first.removeFromParent()
            }
        }
        
        
    }
    
    func move( to pos: CGPoint ) {
        let p = self.position
        if ( pos.x != p.x ) {
            self.position = pos
            self.check_side()
        }
    }
    
    
    func move( step pos: CGPoint ) {
        let p = self.position
        let pos = POS( p.x + pos.x , p.y + pos.y)
        self.move(to: pos)
    }
    
    func move ( on len: CGFloat , speed: CGFloat = 1 ) {
        let p = self.position
        let x = round_move(len * speed )
        let pos = POS( -x , p.y )
        self.move(to: pos)
    }
    
    func round_move( _ num: CGFloat) -> CGFloat {
        let n = Int(num)
        let m = Int(num + 0.5)
        let res:CGFloat = m > n ? CGFloat(n) + 0.5 : CGFloat(n)
        return res
    }
    
}


