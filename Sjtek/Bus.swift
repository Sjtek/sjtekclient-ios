//
//  Bus.swift
//  Sjtek
//
//  Created by Wouter Habets on 07/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import SwiftEventBus

class Bus {
    static func post(_ event: Event) {
        SwiftEventBus.post(event.instanceName(), sender: event)
    }
}
