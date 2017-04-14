//
//  HScene.swift
//  spritekit-demos
//

import SpriteKit

// 场景调度器基础类
protocol HSceneMachine {
    func transition(to scene: BaseScene.Type )
}
// 场景基础类
protocol HScene {
    func render()
}
// 场景名字
enum SceneName {
    case HomeScene
    case SettingScene
    
    func toString()-> String {
        switch self {
        case .HomeScene:
            return "Home"
        case .SettingScene:
            return "Setting"
        }
    }
}
// 调度器
class GameSceneMachine: HSceneMachine {

    var view: SKView!
    var size: CGSize!
    
    init( view: SKView) {
        self.view = view
        self.size = self.view.frame.size
        
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
    }
    
    /// 切换到指定场景
    func transition(to scene: BaseScene.Type ) {
        let s = scene.init( size: self.size )
        s.scene_machine = self
        s.scaleMode = .aspectFill
        s.render()
        self.view.presentScene(s)
    }
}


class BaseScene: SKScene , HScene {
    var scene_machine: GameSceneMachine?
    
    required override init( size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func render() {
        print("render")
    }
}


