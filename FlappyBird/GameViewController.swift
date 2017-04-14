//
//  GameViewController.swift
//  demo
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var machine: GameSceneMachine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            self.machine = GameSceneMachine(view: view)
            self.machine.transition(to: HomeScene.self)
            
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
