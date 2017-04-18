//
//  Store.swift
//  FlappyFird
//

import SpriteKit


enum ActionType {
    case Start, Pause, Gameover, ReStart
    case Fly
}

protocol Emitter {
    func reduce( action: ActionType)
}

class FlappyBirdGame: Emitter {
    
    enum GameStatus {
        case Start , Pause , Gaming , Over
    }
    
    // 前进的速度
    var speed: CGFloat = 4
    // 移动的总路程
    var total: CGFloat = 0
    // 状态
    var status: GameStatus = .Start
    
    var scene: HomeScene
    var time: TimeMachine = TimeMachine()
    var bird: FlappyBird = FlappyBird()
    
    var pipe: FlappyPipe = FlappyPipe()
    
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
        self.pipe.start()
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
        
        self.scene.input_layer.hide()
        self.scene.over_layer.show()
        
        self.bird.over()
        
        self.status = .Over
        
    }
    
    /// 重新开始
    func restart() {
        self.scene.scene_machine?.transition(to: HomeScene.self )
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
            self.pipe.move( dur: v )
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
        case .ReStart:
            self.restart()
        default: break
        }
    }
}



