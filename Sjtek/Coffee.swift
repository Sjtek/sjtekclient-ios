//
//  Coffee.swift
//  Sjtek
//
//  Created by Wouter Habets on 20/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct Coffee: Decodable {
    public let heated: Bool?
    public let lastTriggered: Double?
    
    public init?(json: JSON) {
        self.heated = "heated" <~~ json
        self.lastTriggered = "lastTriggered" <~~ json
    }
}
