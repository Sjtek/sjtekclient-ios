//
//  PlaylistCell.swift
//  Sjtek
//
//  Created by Wouter Habets on 11/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit
import Alamofire

class PlaylistCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setPlaylist(name: String, image: String?) {
        label.text = name
        
        if image != nil {
            self.imageView.af_setImage(
                withURL: URL(string: image!)!,
                placeholderImage: nil,
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        } else {
            self.imageView.image = nil
        }
    }
}
