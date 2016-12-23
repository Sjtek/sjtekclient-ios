//
//  SjtekSocket.swift
//  Sjtek
//
//  Created by Wouter Habets on 11/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import SwiftWebSocket
import SwiftEventBus

/**
    Singleton to connect to the API websocket.
    */
class SjtekSocket {
    
    static let instance = SjtekSocket()

    let url = "ws://ws.sjtek.nl"
    private var websocket = WebSocket()
    
    init() {
        websocket.event.message = onMessage
        websocket.event.close = onClose
    }

    func open() {
        websocket.open(url)
    }
    
    func close() {
        websocket.close()
    }
    
    func onClose(code: Int, reason: String, clean: Bool) {
        
    }
    
    func onMessage(message: Any?) {
        guard let response: Response = Response.from(string: message as! String) else {
            return
        }
        Bus.post(APIResponseEvent(response))
    }
}
