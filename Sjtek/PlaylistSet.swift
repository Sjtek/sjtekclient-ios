//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct PlaylistSet: Decodable {
    public let defaultPlaylist: String?
    public let playlists: Dictionary<String, String>?

    public init?(json: JSON) {
        self.defaultPlaylist = "defaultPlaylist" <~~ json
        self.playlists = "playlists" <~~ json
    }
}
