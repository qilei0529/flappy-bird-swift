//
//  HomeScene.swift
//  spritekit-demos
//

import SpriteKit

let dispacher = Dispacher()


class HomeScene: BaseScene {
    
    lazy var game:FlappyBirdGame = FlappyBirdGame( scene: self )
    
    lazy var start_layer: StartLayer = StartLayer( scene: self )
    lazy var world_layer: WorldLayer = WorldLayer( scene: self )
    
    lazy var input_layer: InputLayer = InputLayer( scene: self )
    
    lazy var over_layer: OverLayer = OverLayer( scene: self )
    
    override func render() {
        self.backgroundColor = .gray
        self.start_layer.render()
        self.world_layer.render()
        self.input_layer.render()
        self.over_layer.render()
        self.input_layer.hide()
        self.over_layer.hide()
        
    }
    
    override func touchesEnded( _ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update( _ currentTime: TimeInterval ) {
        self.game.update( currentTime )
    }
}
