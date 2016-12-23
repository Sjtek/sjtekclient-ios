//
//  APIResponseEvent.swift
//  Sjtek
//
//  Created by Wouter Habets on 07/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

/**
    Event for the state response of the API.
    */
struct APIResponseEvent: Event {

    /// Response object
    let response: Response
    
    init(_ response: Response) {
        self.response = response
    }
    
    static func name() -> String {
        return "APIResponseEvent"
    }
    
    func instanceName() -> String {
        return APIResponseEvent.name()
    }
}
