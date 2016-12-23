//
//  Event.swift
//  Sjtek
//
//  Created by Wouter Habets on 07/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

/**
    Protocol for events used in this app.
    Contains unique ids for the SwiftEventBus library.
    `instanceName` and `name` should return the same id.
    */
protocol Event {
    func instanceName() -> String
    static func name() -> String
}
