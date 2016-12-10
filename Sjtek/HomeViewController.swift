//
//  HomeViewController.swift
//  Sjtek
//
//  Created by Wouter Habets on 10/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit
import SwiftEventBus
import SwiftWebSocket

class HomeViewController: UIViewController {

    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelBarTitle: UILabel!
    @IBOutlet weak var labelBarArtist: UILabel!
    @IBOutlet weak var musicHeight: NSLayoutConstraint!
    
    var expended = false
    var websocket: WebSocket = WebSocket("ws://ws.sjtek.nl")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftEventBus.onMainThread(self, name: APIResponseEvent.name()) {notification in
            let response = (notification.object as! APIResponseEvent).response
            self.update(response: response)
        }
        API.refresh()
        websocket.event.message = { message in
            guard let response: Response = Response.from(string: message as! String) else {
                return
            }
            self.update(response: response)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onNextClick(_ sender: UIButton) {
        API.send(action: Action.Music.next)
    }
    
    @IBAction func onPlayClick(_ sender: UIButton) {
        API.send(action: Action.Music.toggle)
    }
    
    func update(response: Response) {
        let song = response.music?.song!
        self.labelBarTitle.text = song?.title
        self.labelBarArtist.text = song?.artist
    }
    
    func toggleMusicView() {
        if expended {
            expended = false
            UIView.animate(withDuration: 1, animations: {
                self.musicHeight.constant = 0
                self.view.layoutIfNeeded()
            })
        } else {
            expended = true
            UIView.animate(withDuration: 1, animations: {
                self.musicHeight.constant = 200
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
