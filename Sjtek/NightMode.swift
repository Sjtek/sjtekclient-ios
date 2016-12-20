//
//  NightMode.swift
//  Sjtek
//
//  Created by Wouter Habets on 20/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct NightMode: Decodable {
    public let enabled: Bool?
    
    public init?(json: JSON) {
        self.enabled = "enabled" <~~ json
    }
}
