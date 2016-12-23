//
//  NightMode.swift
//  Sjtek
//
//  Created by Wouter Habets on 20/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

/**
    Represents the night mode state of the API.
    */
public struct NightMode: Decodable {
    /// Is night mode enabled.
    public let enabled: Bool?
    
    public init?(json: JSON) {
        self.enabled = "enabled" <~~ json
    }
}
