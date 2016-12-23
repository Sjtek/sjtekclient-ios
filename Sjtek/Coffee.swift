//
//  Coffee.swift
//  Sjtek
//
//  Created by Wouter Habets on 20/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

/**
    This struct represents the state of the coffee machine.
    */
public struct Coffee: Decodable {

    /// Is the coffee machine heated
    public let heated: Bool?
    /// Last time the coffe machine warmed up
    public let lastTriggered: Double?
    
    public init?(json: JSON) {
        self.heated = "heated" <~~ json
        self.lastTriggered = "lastTriggered" <~~ json
    }
}
