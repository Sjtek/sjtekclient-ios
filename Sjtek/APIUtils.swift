//
//  APIUtils.swift
//  Sjtek
//
//  Created by Wouter Habets on 19/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

/**
    Some utils for handling API responses.
    */
class APIUtils {
    private init() {
        
    }

    /**
        Get an image URL for the current playing song.
        Will return the album art if available, otherwise the artist art.
        Or nothing if none of the above are available (in case when no song is queued).
        */
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
