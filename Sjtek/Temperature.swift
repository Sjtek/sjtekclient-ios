//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct Temperature {
    public let outside: Float?
    public let inside: Float?
    public let humidity: Float?
    public let description: String?
    public let icon: String?

    public init?(json: JSON) {
        self.outside = "outside" <~~ json
        self.inside = "inside" <~~ json
        self.humidity = "humidity" <~~ json
        self.description = "description" <~~ json
        self.icon = "icon" <~~ json
    }
}
