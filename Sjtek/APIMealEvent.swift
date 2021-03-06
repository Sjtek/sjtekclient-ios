//
//  APIMealEvent.swift
//  Sjtek
//
//  Created by Wouter Habets on 21/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

/**
    Event for meal suggestion responses.
    */
struct APIMealEvent: Event {

    /// Suggested meal
    let meal: Meal
    
    init(_ meal: Meal) {
        self.meal = meal
    }
    
    static func name() -> String {
        return "APIMealEvent"
    }
    
    func instanceName() -> String {
        return APIMealEvent.name()
    }
}
