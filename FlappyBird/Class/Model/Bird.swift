//
//  Bird.swift
//  FlappyBird
//

import SpriteKit

protocol BirdDelegate {
    func rise( to: CGFloat )
    func move( to: CGFloat )
    func over()
}

class FlappyBird: Emitter {
    
    var delegate: BirdDelegate?
    
    var high: CGFloat = 100
    var speed: CGVector = CGVector(dx: 0, dy: 0)
    
    var imp: CGFloat = 0
    
    func start() {
        self.high = 100
        self.imp = 5
        self.delegate?.move( to:high )
    }
    
    func over() {
        self.delegate?.over()
    }
    
    
    func drop( dur: CGFloat ){
        
        let d = self.reduce_speed(dur: dur)
        
        self.high += d
        
        if self.high > 160 {
            self.speed.dy = 0
            self.high = 160
        }
        
        if self.high < 0 {
            self.high = 0
            dispacher.trigger(action: .Gameover)
        }
        self.delegate?.move( to:high )
        
        if ( self.imp > 0 ) {
            let rot = reduce_rotate(dur: dur)
            self.delegate?.rise(to: rot)
        }
        
    }
    
    func reduce_fly() {
        print("reduce fly")
        self.speed.dy = 100
        self.imp = 12
    }
    
    func reduce_rotate( dur: CGFloat ) -> CGFloat {
        
        var rot: CGFloat = 0
        
        var p = self.imp
        
        p -= dur * 14
        
        if ( p < 0 ) {
            p = 0
        }
        
        let MAX_A:CGFloat = 9
        let MAX_B:CGFloat = 7
        let MAX_C:CGFloat = 3
        
        if p > MAX_A {
            rot = 30
        } else if ( p > MAX_B ) {
            rot = 30 * ( p - MAX_B ) / (MAX_A - MAX_B)
        } else if ( p < MAX_C) {
            rot = 90 * ( p - MAX_C) / MAX_C
        }
        
        
        self.imp = p
        return rot
    }
    
    
    func reduce_speed( dur: CGFloat ) -> CGFloat {
        
        let s = self.speed
        
        
        // 位移系数
        let k:CGFloat = 60
        
        // 加速度
        let a:CGFloat = -10 * k
        
        // 瞬时时间
        let t:CGFloat = dur
        
        // 速度增量
        let vv = a * t * 0.5
        
        // 最终速度
        var v = s.dy + vv
        
        // 限制最大速度
        if v < -200 {
            v = -200
        }
        
        self.speed.dy = v
        
        // 位移增量
        let res = v * t
        
        // print(res , v , vv)
        return res
    }
    
    func reduce(action: ActionType) {
        switch action {
        case .Fly: self.reduce_fly()
        default: break
        }
    }
}
