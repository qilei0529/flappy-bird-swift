//
//  Store.swift
//  FlappyFird
//

import SpriteKit


protocol Emitter {
    func reduce( action: ActionType)
}

protocol BirdDelegate {
    func rise( to: CGFloat )
    func move( to: CGFloat )
}

class FlappyBird: Emitter {
    
    var delegate: BirdDelegate?
    
    var high: CGFloat = 100
    var speed: CGVector = CGVector(dx: 0, dy: 0)
    
    var imp: CGFloat = 0
    
    func start() {
        self.high = 100
        
        self.delegate?.move( to:high )
    }
    
    func reduce_fly() {
        print("reduce fly")
        self.speed.dy = 100
        self.imp = 10
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
    
    func reduce_rotate( dur: CGFloat ) -> CGFloat {
        
        var rot: CGFloat = 0
        
        var p = self.imp
    
        if p > 7 {
            rot = 30
        } else if ( p > 5 ) {
            rot = 30 * ( p - 5 ) / 5
        } else if ( p < 2) {
            rot = 90 * ( p - 2) / 2
        }
        
        p -= dur * 14
        
        if ( p < 0 ) {
            p = 0
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


class FlappyBirdGame: Emitter {
    
    
    enum GameStatus {
        case Start , Pause , Gaming
    }
    var speed: CGFloat = 4
    
    var total: CGFloat = 0
    
    var status: GameStatus = .Start
    
    var scene: HomeScene
    var time: TimeMachine = TimeMachine()
    var bird: FlappyBird = FlappyBird()
    
    init( scene: HomeScene ) {
        self.scene = scene
        
        // clean actions
        dispacher.actions = []
        // bind
        dispacher.bind(action: self)
        dispacher.bind(action: bird)
        self.bird.delegate = self.scene.world_layer.bird
        
        // move
        self.status = .Start
        
        self.bird.start()
    }
    
    /// 游戏开始
    func start() {
        print("game start")
        self.scene.start_layer.hide()
        self.scene.input_layer.show()
        
        self.status = .Gaming
        
        self.speed = 8
    }
    
    /// 游戏暂停
    func pause() {
        print("game pause")
        self.status = .Pause
    }
    
    /// 游戏结束
    func gameover() {
        print("game over")
        self.scene.scene_machine?.transition(to: SettingScene.self )
    }
    
    /// 时间更新
    func update(  _ currentTime: TimeInterval ) {
        let dur = self.time.update(currentTime)
        if status == .Start || status == .Gaming {
            total += CGFloat(dur) * speed
            self.scene.world_layer.move(to: total)
        }
        
        if status == .Gaming {
            let v = CGFloat(dur)
            self.bird.drop( dur: v )
        }
        
    }
    
    
    ///
    func reduce(action: ActionType) {
        switch action {
        case .Start:
            self.start()
        case .Pause:
            self.pause()
        case .Gameover:
            self.gameover()
        default: break
        }
    }
}



