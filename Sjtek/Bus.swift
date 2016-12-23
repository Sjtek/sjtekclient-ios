//
//  Bus.swift
//  Sjtek
//
//  Created by Wouter Habets on 07/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import SwiftEventBus

/**
    Class to send events over the event bus.
    */
class Bus {

    /**
        Send an event.
        */
    static func post(_ event: Event) {
        SwiftEventBus.post(event.instanceName(), sender: event)
    }
}
