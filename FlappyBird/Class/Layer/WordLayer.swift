//
//  BackLayer.swift
//  FlappyFird
//

import SpriteKit

class WorldLayer: Layer {
    
    lazy var background: SKSpriteNode = {
        let b = SKSpriteNode(color: RGBA(112, 197, 206, 1), size: self.size)
        b.anchorPoint = POS(0,0)
        return b
    }()
    
    
    lazy var root: CloneView = {
        
        let s = SIZE(self.size.width, 100)
        let b = CloneView(name: "root", size: s)
        b.position = POS(0, 0)
        b.zPosition = 10
        return b
    }()
    
    lazy var cloud: CloneView = {
        
        let s = SIZE(self.size.width, 150)
        let b = CloneView(name: "back_cloud", size: s)
        b.position = POS(0, 60)
        b.zPosition = 1
        return b
    }()
    
    lazy var build: CloneView = {
        
        let s = SIZE(self.size.width, 80)
        let b = CloneView(name: "back_build", size: s)
        
        b.position = POS(0, 75)
        b.zPosition = 3
        return b
    }()
    
    lazy var build_shade: CloneView = {
        
        let s = SIZE(self.size.width, 80)
        let b = CloneView(name: "back_build_shade", size: s , pos: POS( -20, 0 ))
        
        b.position = POS(0, 70)
        b.zPosition = 2
        return b
    }()
    
    lazy var grass: CloneView = {
        
        let s = SIZE(self.size.width, 40)
        let b = CloneView(name: "back_grass", size: s)
        b.position = POS(0, 50)
        b.zPosition = 4
        return b
    }()
    
    lazy var bird: BirdView = {
        let b = BirdView()
            b.scene_size = self.size
            b.zPosition = 20
            b.move(to: 0)
        return b
    }()
    
    lazy var pipe: GodView = {
        let b = GodView()
            b.scene_size = self.size
            b.zPosition = 5
            b.render()
        return b
    }()
    
    override func render() {
        super.render()
        self.node.zPosition = 1
        self.node.addChild(background)
        self.node.addChild(cloud)
        self.node.addChild(build_shade)
        self.node.addChild(build)
        self.node.addChild(grass)
        
        self.node.addChild(root)
        
        self.node.addChild(bird)
        
        self.node.addChild(pipe)
        
    }
    
    
    func move( to t: CGFloat ) {
        
        self.cloud.move(on: t)
        self.build_shade.move(on: t , speed: 3)
        self.build.move(on: t , speed: 4)
        self.grass.move(on: t , speed: 8)
        self.root.move(on: t , speed: 10)
        
    }
    
}


