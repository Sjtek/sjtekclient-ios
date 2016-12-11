//
//  PlaylistCell.swift
//  Sjtek
//
//  Created by Wouter Habets on 11/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit

class PlaylistCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setPlaylist(name: String) {
        label.text = name
    }
}
