
//
//  Dispacher
//  spritekit-demos
//


enum ActionType {
    case Start, Pause, Gameover
    case Fly
}

class Dispacher {
    
    var actions: [Emitter] = []
    
    func trigger( action: ActionType ) {
        print("trigger action", action)
        self.actions.forEach { ( e ) in
            e.reduce(action: action)
        }
    }
    
    func bind( action: Emitter ) {
        print("bind \(action)")
        self.actions.append(action)
    }
    
}
