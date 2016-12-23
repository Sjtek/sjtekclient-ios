//
//  PlaylistInterfaceController.swift
//  Sjtek
//
//  Created by Wouter Habets on 15/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import WatchKit
import Foundation


class PlaylistInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    let playlists: [String]? = Storage.playlists

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        loadPlaylists()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func loadPlaylists() {
        print(playlists)
        guard playlists != nil else {
            return
        }
        
        tableView.setNumberOfRows((playlists?.count)!, withRowType: "PlaylistRow")
        for index in 1...(playlists?.count)! {
             let row = tableView.rowController(at: index) as? PlaylistRow
                row?.setPlaylist(name: (playlists?[index])!)
        }
    }
}
