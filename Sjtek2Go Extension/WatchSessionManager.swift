//
//  WatchSessionManager.swift
//  Sjtek
//
//  Created by Wouter Habets on 18/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import WatchConnectivity

/// Not used
class WatchSessionManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchSessionManager()
    private override init() {
        super.init()
    }
    
    private let session: WCSession = WCSession.default()
    
    func startSession() {
        session.delegate = self
        session.activate()
        print("Enne")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Activation completed with \(error) \(activationState)")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Did receive application context")
    }
}
