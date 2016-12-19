//
//  WatchSessionManager.swift
//  Sjtek
//
//  Created by Wouter Habets on 18/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import WatchConnectivity
import SwiftEventBus

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    private var response: Response?
    private var settings: Settings?

    static let sharedManager = WatchSessionManager()
    private override init() {
        super.init()
        response = State.instance.response
        settings = State.instance.settings
        SwiftEventBus.onMainThread(self, name: APIResponseEvent.name()) {notification in
            let response = (notification.object as! APIResponseEvent).response
            self.response = response
            self.send()
        }
        SwiftEventBus.onMainThread(self, name: APISettingsEvent.name()) {notification in
            let settings = (notification.object as! APISettingsEvent).settings
            self.settings = settings
            self.send()
        }
    }
    
    func send(response: Response) {
        self.response = response
        send()
    }
    
    private func send() {
        print("Sending update")
        var playlists: [String]
        if let dic = settings?.users?[Preferences.username]?.playlistSet?.playlists?.keys {
            playlists = Array(dic)
        } else {
            playlists = Array()
        }
        
        let data: Dictionary<String, Any> = [
            "inside": 25,
            "outside": 10,
            "playlists": playlists
        ]
        
        do {
            try session?.updateApplicationContext(data)
        } catch {
            print("Sending error")
        }
        
    }
    
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    private var validSession: WCSession? {
        
        // paired - the user has to have their device paired to the watch
        // watchAppInstalled - the user must have your watch app installed
        
        // Note: if the device is paired, but your watch app is not installed
        // consider prompting the user to install it for a better experience
        
        if let session = session, session.isPaired && session.isWatchAppInstalled {
            return session
        }
        return nil
    }
    
    func startSession() {
        session?.delegate = self
        session?.activate()
        print("Enne")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Activation did complete with \(error) \(activationState.rawValue)")
        if error != nil {
            send()
        }
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
}
