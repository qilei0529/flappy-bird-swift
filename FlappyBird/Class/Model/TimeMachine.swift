//
//  TimeMachine.swift
//  FlappyBird
//

import Foundation


class TimeMachine {
    
    var time: TimeInterval = 0
    var dur: TimeInterval = 0
    
    func update(  _ currentTime: TimeInterval ) -> TimeInterval {
        
        if time == 0 {
            time = currentTime
            dur = 0
        }else{
            dur = currentTime - time
            if ( dur > 0.5 ) {
                dur = 0
            }
            time = currentTime
        }
        
        return dur
    }
}
