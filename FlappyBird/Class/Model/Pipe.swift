//
//  Pipe.swift
//  FlappyBird
//

import SpriteKit


protocol PipeDelegate {
    func rise( to: CGFloat )
    func move( to: CGFloat )
    func over()
}

// 管道
class FlappyPipe {
    
    var total: CGFloat = 0
    
    var delegate: PipeDelegate?
    
    func start() {
        self.total = 0
    }
    
    func move( to num: CGFloat) {
        print("pipe move:", ROUND(num) )
    }
    
    func move( dur num: CGFloat) {
        self.total += num * 8
        self.move(to: self.total)
    }
}
