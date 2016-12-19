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
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController {
    
    let animationSpeed = 0.2
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelBarTitle: UILabel!
    @IBOutlet weak var labelBarArtist: UILabel!
    @IBOutlet weak var musicHeight: NSLayoutConstraint!
    @IBOutlet weak var musicBar: UIView!
    @IBOutlet weak var musicView: UIView!
    @IBOutlet weak var musicBarHeight: NSLayoutConstraint!
    @IBOutlet weak var musicControls: UIView!
    @IBOutlet weak var musicHeader: UILabel!
    
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        toggleMusicView()
    }
    var expended = false
    var websocket: WebSocket = WebSocket("ws://ws.sjtek.nl")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftEventBus.onMainThread(self, name: APIResponseEvent.name()) {notification in
            let response = (notification.object as! APIResponseEvent).response
            self.update(response: response)
        }
        
        if let response = State.instance.response {
            update(response: response)
        }
        
        API.refresh()
        API.data()
        SjtekSocket.instance.open()
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
        
        setImage(response: response)
    }
    
    func setImage(response: Response) {
        let url = APIUtils.imageUrl(response: response)
        if !url.isEmpty {
            self.imageViewBackground.af_setImage(
                withURL: URL(string: url)!,
                placeholderImage: nil,
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        } else {
            self.imageViewBackground.image = nil
        }
    }
    
    func toggleMusicView() {
        if expended {
            expended = false
            UIView.animate(withDuration: animationSpeed, animations: {
                self.musicHeight.constant = 0
                self.view.layoutIfNeeded()
            })
        } else {
            expended = true
            UIView.animate(withDuration: animationSpeed, animations: {
                self.musicHeight.constant = 200
                self.view.layoutIfNeeded()
            })
        }
    }
    
    var translationStart: CGFloat = 0
    var translationUp: Bool = false
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        view.layoutIfNeeded()
        
        let translation = sender.translation(in: musicBar)
        switch (sender.state) {
        case .began:
            translationStart = musicHeight.constant
            
        case .changed:
            let ty = -translation.y
            translationUp = ty > 0
            musicHeight.constant = (translationStart + ty)
            view.layoutIfNeeded()
            
        case .ended:
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: {
                            self.musicHeight.constant = (self.translationUp ? self.maxHeight() : 0)
                            self.musicHeader.alpha = (self.translationUp ? 1.0 : 0.0)
                            self.view.setNeedsUpdateConstraints()
                            self.view.layoutIfNeeded()
            },
                           completion: nil)
            
        default:
            break
        }
        
    }
    
    func maxHeight() -> CGFloat {
        return self.view.frame.height - (self.musicBarHeight.constant * 2)
    }
    
}
