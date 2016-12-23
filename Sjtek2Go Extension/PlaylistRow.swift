//
//  PlaylistRow.swift
//  Sjtek
//
//  Created by Wouter Habets on 22/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import WatchKit

class PlaylistRow: NSObject {
    
    @IBOutlet var labelName: WKInterfaceLabel!
    
    func setPlaylist(name: String) {
        self.labelName.setText(name)
        print("Loading playlist: \(name)")
    }
}
