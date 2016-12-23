//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

/**
    Representing a set of playlists with a default one.
    */
public struct PlaylistSet: Decodable {
    /// The default playlist to play
    public let defaultPlaylist: String?
    /// Set of playlist with names and URIs
    public let playlists: Dictionary<String, String>?

    public init?(json: JSON) {
        self.defaultPlaylist = "defaultPlaylist" <~~ json
        self.playlists = "playlists" <~~ json
    }
}
