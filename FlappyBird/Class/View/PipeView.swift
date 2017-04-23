//
//  PipeView.swift
//  FlappyBird
//

import SpriteKit



class GodView: SKNode , PipeDelegate {
    
    var scene_size: CGSize = SIZE(0,0)
    
    var pipe_list: [PipeView] = [PipeView]()
    
    lazy var box: SKSpriteNode = {
        let b = SKSpriteNode(color: RGBA(20, 0, 0, 0.5), size: SIZE(600, 100))
        let m = MID(self.scene_size)
        b.anchorPoint = POS(0, 0)
        b.position = POS( m.x - 50, 60 )
        return b
    }()
    
    func move(to point: CGFloat) {
        
        let x = ROUND( -point * 10 )
        let p = self.position;
        if ( x != p.x) {
            self.position = POS(x, p.y)
        }
        
    }
    
    func over() {
        
    }
    
    func remove(index: Int) {
        let b = self.pipe_list.removeFirst()
        b.removeFromParent()
    }
    
    func create(pipe: Pipe) {
        
        let h = pipe.high
        let size = self.scene_size
        let loc = pipe.loc
        let b = PipeView( high: h , gap: pipe.gap, size: size)
        
            b.position = POS( loc , 0 )
        
        self.addChild(b)
        
        self.pipe_list.append(b)
        
    }
    
    func render() {
        //        self.addChild(self.box)
    }
}


class PipeView: SKNode {
    
    var high : CGFloat
    
    var loc : CGPoint
    
    var gap : CGFloat
    
    var size : CGSize
    
    var texture_body: SKTexture = SKTexture(imageNamed: "pipe_body")
    var texture_top: SKTexture = SKTexture(imageNamed: "pipe_top")
    
    lazy var tbox: SKSpriteNode = {
        
        let b = SKSpriteNode(color: RGBA(200, 0, 100, 0), size: SIZE(60, self.gap))
//        b.anchorPoint = POS(0, 0)
        
        b.position = self.loc
        b.zPosition = 2
        
        b.addChild(self.box_btm)
        b.addChild(self.box_top)
        b.addChild(self.box_gan_btm)
        b.addChild(self.box_gan_top)
        return b
    }()
    
    lazy var box_gan_btm: SKSpriteNode = {
        let g = ROUND(-self.gap / 2)
        let size = SIZE(80, 40)
        let b = SKSpriteNode(texture: self.texture_top, size: size)
        b.anchorPoint = POS(0.5, 1)
        b.position = POS(0 , g)
        b.zPosition = 1
        return b
    }()
    lazy var box_gan_top: SKSpriteNode = {
        let g = ROUND(self.gap / 2)
        let size = SIZE(80, 40)
        let b = SKSpriteNode(texture: self.texture_top, size: size)
        b.anchorPoint = POS(0.5, 0)
        b.position = POS(0 , g)
        b.zPosition = 1
        
        return b
    }()
    
    lazy var box_btm: SKSpriteNode = {
        let g = ROUND(-self.gap / 2 - 10)
        let size = SIZE(80, self.size.height)
        let b = SKSpriteNode(texture: self.texture_body, size: size)
        b.anchorPoint = POS(0.5, 1)
        b.position = POS(0 , g)
        
        return b
    }()
    
    lazy var box_top: SKSpriteNode = {
        
        let g = ROUND(self.gap / 2 + 10)
        let size = SIZE(80, self.size.height)
        let b = SKSpriteNode(texture: self.texture_body, size: size)
        b.anchorPoint = POS(0.5, 0)
        b.position = POS(0 , g)
        
        return b
    }()
    
    
    init( high: CGFloat , gap: CGFloat,  size: CGSize ) {
        self.high = high
        self.size = size
        self.gap = gap * 10
        
        self.loc = POS(0, ROUND( self.size.height * self.high / 100) + 60)
        super.init()
        self.addChild(tbox)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
