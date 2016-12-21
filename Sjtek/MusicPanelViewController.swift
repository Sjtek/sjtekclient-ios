//
//  MusicPanelViewController.swift
//  Sjtek
//
//  Created by Wouter Habets on 19/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit
import SwiftEventBus

class MusicPanelViewController: UIViewController {

    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var imageViewForeground: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var buttonRewind: UIButton!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonForward: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRewind.imageView?.contentMode = .scaleAspectFit
        buttonPlay.imageView?.contentMode = .scaleAspectFit
        buttonForward.imageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerEvents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        unregisterEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageViewBackground.image = nil
        imageViewForeground.image = nil
    }
    
    func registerEvents() {
        SwiftEventBus.onMainThread(self, name: APIResponseEvent.name()) {notification in
            let response = (notification.object as! APIResponseEvent).response
            self.update(response: response)
        }
    }
    
    func unregisterEvents() {
        SwiftEventBus.unregister(self)
    }
    
    func update(response: Response) {
        setImage(response: response)
        if let music = response.music {
            sliderVolume.value = Float(music.volume!)
            if let song = music.song {
                labelTitle.text = song.title
                labelArtist.text = song.artist
            }
        }
        
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
            self.imageViewForeground.af_setImage(
                withURL: URL(string: url)!,
                placeholderImage: nil,
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        } else {
            self.imageViewBackground.image = nil
            self.imageViewForeground.image = nil
        }
    }

    @IBAction func onPreviousClick(_ sender: Any) {
        API.send(action: Action.Music.previous)
    }
    
    @IBAction func onToggleClick(_ sender: Any) {
        API.send(action: Action.Music.toggle)
    }
    
    @IBAction func onNextClick(_ sender: Any) {
        API.send(action: Action.Music.next)
    }
    
    @IBAction func onShuffleClick(_ sender: Any) {
        API.send(action: Action.Music.shuffle)
    }
    
    @IBAction func onClearClick(_ sender: Any) {
        API.send(action: Action.Music.clear)
    }
    
    @IBAction func onVolumeSlide(_ sender: Any) {
        
    }
}
