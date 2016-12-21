//
//  MEal.swift
//  Sjtek
//
//  Created by Wouter Habets on 21/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct Meal: Decodable {
    public let id: Int?
    public let name: String?
    
    public init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
    }
}
