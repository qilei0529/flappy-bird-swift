//
//  Pipe.swift
//  FlappyBird
//

import SpriteKit


protocol PipeDelegate {
    
    func create( pipe: Pipe )
    
    func move( to: CGFloat )
    func over()
    
    func remove( index: Int )
}

struct Pipe {
    var gap : CGFloat
    var high: CGFloat
    var loc : CGFloat
}


// 管道
class FlappyPipe {
    
    var total: CGFloat = 0
    
    var next: CGFloat = 0
    
    var step: CGFloat = 200
    
    var last_high: CGFloat = 50
    
    
    var pipe_stack: [Pipe] = []
    
    var pipe_stash: [Pipe] = []
    
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
        
        let rand:CGFloat = ROUND(CGFloat(RAND()) / 10) // 0 ~ 100
        let len:CGFloat = 50
        let max:CGFloat = 70
        let min:CGFloat = 30
        
        let move = rand - len   // -50 ~ 50
        
        var high = 50 + move
        
        if high > max {
            high = max - (high - max)
        }else if high < min {
            high = min - (high - min)
        }
        
        print("create pipe" , move,  high , last_high)
        
        let loc:CGFloat = self.next + step
        
        let pipe = Pipe(gap: 8, high: high, loc: loc)
        
        self.pipe_stack.append(pipe)
        self.next = loc
        
        self.last_high = high
        
        self.delegate?.create(pipe: pipe)
        
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
                }
            }
            
            if clear {
                self.pipe_stack.removeFirst()
                self.delegate?.remove(index: 0)
            }
            
        }
    }
    
    func move( step: CGFloat) {
        self.total += step
        self.delegate?.move(to: self.total)
        
        self.check_create()
    }
}
