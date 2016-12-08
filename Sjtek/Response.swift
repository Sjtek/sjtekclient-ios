//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct Response: Decodable {

    public let lights: Lights?
    public let music: Music?
    public let temperature: Temperature?

    public init?(json: JSON) {
        self.temperature = "temperature" <~~ json
        self.lights = "lights" <~~ json
        self.music = "music" <~~ json
    }
}
