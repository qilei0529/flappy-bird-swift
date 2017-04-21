//
//  Pipe.swift
//  FlappyBird
//

import SpriteKit


protocol PipeDelegate {
    func add( node:SKNode )
    func move( to: CGFloat )
    func over()
}


class GodView: SKNode , PipeDelegate {
    var scene_size: CGSize = SIZE(0,0)
    
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
    
    func add( node: SKNode ) {
        self.addChild(node)
    }
    
    func render() {
//        self.addChild(self.box)
    }
}


class PipeView: SKNode {
    
    lazy var box: SKSpriteNode = {
        let b = SKSpriteNode(color: RGBA(20, 100, 0, 0.8), size: SIZE(60, 200))
        b.anchorPoint = POS(0.5, 0)
        return b
    }()
    
    func render() {
        self.addChild(self.box)
    }
    
}

// 管道
class FlappyPipe {
    
    var total: CGFloat = 0
    
    var next: CGFloat = 0
    
    var step: CGFloat = 200
    
    
    struct Pipe {
        var gap : CGFloat
        var high: CGFloat
        var loc : CGFloat
        var node: PipeView
    }
    
    var pipe_stack: [Pipe] = []
    
    var delegate: PipeDelegate?
    
    func start() {
        self.total = 0
        self.next = 300
        for _ in 1 ... 3 {
            self.create()
        }
    }
    
    // 新建
    func create() {
        let high:CGFloat = ROUND(CGFloat(RAND()) / 10)
//        print(high)
        
        let loc:CGFloat = self.next + step
        
        let box = PipeView()
            box.render()
            box.position = POS( loc,  60)
        let pipe = Pipe(gap: 10, high: high, loc: loc, node: box)
        self.pipe_stack.append(pipe)
        
        self.next = loc
        
        self.delegate?.add(node: box)
    }

    func check_create() {
        let len = self.total * 10
        if ( len > self.next - self.step) {
            self.create()
            
            
            var clear = false
            
            if let box = self.pipe_stack.first {
                print(len , box.loc)
                if len > box.loc + 300 {
                    clear = true
                    box.node.removeFromParent()
                }
            }
            
            if clear {
                self.pipe_stack.removeFirst()
            }
            
        }
    }
    
    func move( step: CGFloat) {
        self.total += step
        self.delegate?.move(to: self.total)
        
//        print("move",self.total)
        self.check_create()
    }
}
