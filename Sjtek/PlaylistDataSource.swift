//
//  PlaylistDataSource.swift
//  Sjtek
//
//  Created by Wouter Habets on 11/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import UIKit

class PlaylistDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let playlists: Dictionary<String, String>
    let playlistNames: [String]
    
    init(playlistSet: PlaylistSet) {
        playlists = playlistSet.playlists!
        playlistNames = Array(playlists.keys)
        print("Init \(playlistNames.count)")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("Sections 1")
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Count \(playlistNames.count)")
        return playlistNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Dequeue cell for \(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCell", for: indexPath)
        let playlistCell = cell as! PlaylistCell
        playlistCell.setPlaylist(name: playlistNames[indexPath.row])
        return playlistCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playlist = playlists[playlistNames[indexPath.row]]
        let arguments = Arguments(action: Action.Music.start)
        arguments.playlist = playlist!
        API.send(arguments: arguments)
    }
}
