//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

/**
    Represents the temperature sensors around the house.
    */
public struct Temperature: Decodable {
    /// Outside temperature
    public let outside: Float?
    /// Inside temperature
    public let inside: Float?
    /// Outside humidity
    public let humidity: Float?
    /// Description of the weather outside
    public let description: String?
    /// Icon URL representing the weather outside
    public let icon: String?

    public init?(json: JSON) {
        self.outside = "outside" <~~ json
        self.inside = "inside" <~~ json
        self.humidity = "humidity" <~~ json
        self.description = "description" <~~ json
        self.icon = "icon" <~~ json
    }
}
