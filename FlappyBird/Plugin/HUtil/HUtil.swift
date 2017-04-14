//
//  Common.swift
//  Land


import SpriteKit

// UIColor

func RGBA( _ red:CGFloat , _ green:CGFloat, _ blue:CGFloat, _ alpha:CGFloat) -> SKColor{
    let color = SKColor(red: red / 255, green: green/255, blue: blue / 255, alpha: alpha)
    return color
}

// Size
func SIZE( _ width:CGFloat , _ height:CGFloat) -> CGSize {
    return CGSize(width: width, height: height)
}

// Pos
func POS( _ x:CGFloat , _ y:CGFloat ) -> CGPoint {
    return CGPoint(x: x, y: y)
}

func P2P( pos: CGPoint , anchor: CGPoint = POS(0.5, 0.5) , size: CGSize = SIZE(0, 0) , box: CGSize = SIZE(0, 0) ) -> CGPoint {
    
    let s = size
    let b = box
    let a = anchor
    
    let p = POS( pos.x + (a.x - 0.5) * s.width  - ( a.x - 0.5) * b.width ,
                 pos.y + (a.y - 0.5) * s.height - ( a.y - 0.5) * b.height )
    return p
    
}

func P2L( pos: CGPoint , anchor: CGPoint = POS(0, 0) , size: CGSize = SIZE(0, 0) ,  box: CGSize = SIZE(0,0) ) -> CGPoint {
    
    let s = size
    let b = box
    let a = anchor
    let p = POS( pos.x + s.width  * a.x - b.width  * (a.x - 0.5) ,
                 pos.y + s.height * a.y - b.height * (a.y - 0.5) )
    
    return p
}

func P2Z( pos: CGPoint , anchor: CGPoint = POS(0, 0) , size: CGSize = SIZE(0, 0) ,  box: CGSize = SIZE(0,0) ) -> CGPoint {
    
    let s = size
    let b = box
    let a = anchor
    let p = POS( pos.x + s.width  * a.x - b.width  * (a.x) ,
                 pos.y + s.height * a.y - b.height * (a.y) )
    
    return p
}

// MID

func MID( _ size:CGSize) -> CGPoint {
    return CGPoint(x: size.width / 2, y: size.height / 2)
}

