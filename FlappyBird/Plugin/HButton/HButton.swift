//
//  HButton.swift
//  spritekit-demos
//

import SpriteKit


class LabelButton : HButton {
    
    var label: SKLabelNode = {
        let b = SKLabelNode()
        b.fontName = "Chalkboard SE"
        b.fontSize = 20
        b.fontColor = .white
        b.position = POS(0, -7)
        return b
    }()
    
    func setTitle( title: String , color: SKColor = .white) {
        self.label.text = title
        self.label.fontColor = color
        self.box.addChild(label)
    }
}

class HButton: SKNode {
    
    // MARK: Nested Types
    enum ControlEvent {
        case TouchNone
        case TouchDown // on all touch downs
        case TouchUpInside
    }
    
    var size: CGSize!
    
    var isTouch: Bool = false
    
    var box: SKSpriteNode!
    
    internal var events:[(event: ControlEvent, closure: () -> Void )] = []
    
    init(color: SKColor, size: CGSize ) {
        super.init()
        self.isUserInteractionEnabled = true
        self.size = size
        self.box = SKSpriteNode(color: color, size: self.size)
        self.addChild(box)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func active( on: Bool ) {
        
        if ( on == self.isTouch ) {
            return
        }
        
        self.isTouch = on
        
        let s: CGFloat = on == true ? 1.06 : 1
        let zoom = SKAction.scale(to: s, duration: 0.1)
        
        self.box.run(zoom, withKey: "active")
    }
    
    open func onPress( closure: @escaping () -> Void  ) {
        self.addTarget(event: .TouchUpInside, closure: closure)
    }
    
    open func addTarget( event: ControlEvent , closure: @escaping () -> Void ) {
        self.events.append((event:event , closure: closure))
    }
    
    private func trigger(event: ControlEvent) {
        for clo in events {
            if clo.event == event {
                clo.closure()
            }
        }
    }
    
    private func isInside (loc : CGPoint) -> Bool {
        let w = size.width / 2
        let h = size.height / 2
        if loc.x < -w || loc.y < -h || loc.x > w || loc.y > h {
            return false
        }
        return true
    }
    
    private func touchDown(atPoint pos : CGPoint) {
        self.active(on: true)
        self.trigger(event: .TouchDown)
    }
    
    private func touchUp(atPoint pos : CGPoint) {
        
        let on = isInside(loc: pos)
        if ( on ) {
            self.trigger(event: .TouchUpInside)
        }
        
        self.active(on: false)
    }
    
    private func touchMove(atPoint pos : CGPoint) {
        let on = isInside(loc: pos)
        self.active(on: on)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMove(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
}
