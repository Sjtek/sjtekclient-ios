//
//  APIErrorEvent.swift
//  Sjtek
//
//  Created by Wouter Habets on 07/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

struct APIErrorEvent: Event {
    let code: Int
    
    init(code: Int) {
        self.code = code
    }
    
    static func name() -> String {
        return "APIErrorEvent"
    }
    
    func instanceName() -> String {
        return APIErrorEvent.name()
    }
}
