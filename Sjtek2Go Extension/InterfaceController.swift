//
//  InterfaceController.swift
//  Sjtek2Go Extension
//
//  Created by Wouter Habets on 15/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var labelInside: WKInterfaceLabel!
    @IBOutlet var labelOutside: WKInterfaceLabel!
    
    var session: WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        session = WCSession.default()
        session?.delegate = self
        session?.activate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func update(data: [String : Any]) {
        print("data: \(data)")
        if let tempIn = data["inside"] as? Int {
            labelInside.setText("\(tempIn)")
        }
        if let tempOut = data["outside"] as? Int {
            labelOutside.setText("\(tempOut)")
        }
    }

    @IBAction func onToggleClick() {

    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Activation completed with \(error) \(activationState)")
        update(data: session.applicationContext)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Did receive application context")
        update(data: applicationContext)
    }

}
