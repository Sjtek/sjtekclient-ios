//
//  Action.swift
//  Sjtek
//
//  Created by Wouter Habets on 04/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

public protocol ActionPath {
    func path() -> String
}

public enum Action: String, ActionPath {
    case refresh = "/info"
    case toggle = "/toggle"
    case data = "/data"
    
    public func path() -> String {
        return self.rawValue
    }

    public enum Lights: String, ActionPath {
        case toggle1 = "/lights/toggle1"
        case toggle1on = "/lights/toggle1on"
        case toggle1off = "/lights/toggle1off"
        case toggle2 = "/lights/toggle2"
        case toggle2on = "/lights/toggle2on"
        case toggle2off = "/lights/toggle2off"
        case toggle3 = "/lights/toggle3"
        case toggle3on = "/lights/toggle3on"
        case toggle3off = "/lights/toggle3off"
        
        public func path() -> String {
            return self.rawValue
        }
    }

    public enum Music: String, ActionPath {
        case toggle = "/music/toggle"
        case play = "/music/play"
        case pause = "/music/pause"
        case stop = "/music/stop"
        case next = "/music/next"
        case previous = "/music/previous"
        case shuffle = "/music/shuffle"
        case clear = "/music/clear"
        case volumeLower = "/music/volumelower"
        case volumeRaise = "/music/volumeraise"
        case volumeNeutral = "/music/volumeneutral"
        case start = "/music/start"
        
        public func path() -> String {
            return self.rawValue
        }
    }

    public enum Coffee: String, ActionPath {
        case start = "/coffee/start"
        
        public func path() -> String {
            return self.rawValue
        }
    }

    public enum NightMode: String, ActionPath {
        case enable = "/nightmode/enable"
        case disable = "/nightmode/disable"
        
        public func path() -> String {
            return self.rawValue
        }
    }

    public enum TV: String, ActionPath {
        case powerOff = "/tv/off"
        case volumeLower = "/tv/volumelower"
        case volumeRaise = "/tv/volumeraise"
        
        public func path() -> String {
            return self.rawValue
        }
    }

    public enum Screen: String, ActionPath {
        case fullscreen = "/screen/fullscreen"
        case music = "/screen/music"
        case tv = "/screen/tv"
        case countdown = "/screen/countdown"
        case newYear = "/screen/newyear"
        case refresh = "/screen/refresh"
        
        public func path() -> String {
            return self.rawValue
        }
    }
}
