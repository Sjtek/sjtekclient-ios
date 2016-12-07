//
//  Event.swift
//  Sjtek
//
//  Created by Wouter Habets on 07/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

protocol Event {
    func instanceName() -> String
    static func name() -> String
}
