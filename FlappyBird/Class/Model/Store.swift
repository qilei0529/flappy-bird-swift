//
//  Store.swift
//  FlappyFird
//

import SpriteKit


protocol Emitter {
    func reduce( action: ActionType)
}

protocol BirdDelegate {
    func fly()
    
    func move( to: CGFloat )
}

class FlappyBird: Emitter {
    
    var delegate: BirdDelegate?
    
    var high: CGFloat = 100
    var speed: CGVector = CGVector(dx: 0, dy: 0)
    
    func start() {
        self.high = 100
        
        self.delegate?.move( to:high )
    }
    
    func reduce_fly() {
        print("reduce fly")
        self.speed.dy = 40
    }
    
    func drop( dur: CGFloat ){
        
        let d = self.reduce_speed(dur: dur)
        self.high += d
        
        
        if self.high > 160 {
            self.high = 160
        }
        
        if self.high < 0 {
            self.high = 0
            dispacher.trigger(action: .Gameover)
        }
        self.delegate?.move( to:high )
        
    }
    
    func reduce_speed( dur: CGFloat ) -> CGFloat {
        
        let a:CGFloat = -10
        let k:CGFloat = 16
        let t:CGFloat = dur * k
        
        let s = self.speed
        let dy = s.dy + a * t
        
        let res = dy * t * t
        
        self.speed = CGVector(dx:s.dx, dy: dy)
        
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



