//
//  APIDataEvent.swift
//  Sjtek
//
//  Created by Wouter Habets on 07/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

/**
    Event for the settings response of the API.
    */
struct APISettingsEvent: Event {

    /// Settings object
    let settings: Settings
    
    init(settings: Settings) {
        self.settings = settings
    }
    
    static func name() -> String {
        return "APISettingsEvent"
    }
    
    func instanceName() -> String {
        return APISettingsEvent.name()
    }
}
