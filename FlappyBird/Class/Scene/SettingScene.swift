//
//  SettingScene.swift
//  spritekit-demos
//
import SpriteKit

class SettingScene: BaseScene {
    
    override func render() {
        self.backgroundColor = .blue
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scene_machine?.transition(to: HomeScene.self )
    }
    
}
