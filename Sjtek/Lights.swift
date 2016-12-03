//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct Lights: Decodable {
    public let light1: Bool?
    public let light2: Bool?
    public let light3: Bool?
    public let light4: Bool?

    public init?(json: JSON) {
        self.light1 = "1" <~~ json
        self.light2 = "2" <~~ json
        self.light3 = "3" <~~ json
        self.light4 = "4" <~~ json
    }
}
