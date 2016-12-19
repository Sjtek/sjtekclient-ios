//
//  APIUtils.swift
//  Sjtek
//
//  Created by Wouter Habets on 19/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

class APIUtils {
    private init() {
        
    }
    
    public static func imageUrl(response: Response) -> String {
        guard let song = response.music?.song else {
            return ""
        }
        
        var url: String = ""
        if let albumArt = song.albumArt {
            if !albumArt.isEmpty {
                url = albumArt
            }
        }
        if url.isEmpty {
            if let artistArt = song.artistArt {
                if !artistArt.isEmpty {
                    url = artistArt
                }
            }
        }
        
        if !url.isEmpty {
            return url
        } else {
            return ""
        }
    }
}
