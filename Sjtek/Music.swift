//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct Music: Decodable {
    public let volume: Int?
    public let state: PlaybackState?
    public let song: Song?

    public init?(json: JSON) {
        self.volume = "volume" <~~ json
        self.state = "state" <~~ json
        self.song = "song" <~~ json
    }

    public enum PlaybackState: String {
        case Stopped = "STATUS_STOPPED"
        case Playing = "STATUS_PLAYING"
        case Paused = "STATUS_PAUSED"
        case Error = "ERROR"
    }

    public struct Song: Decodable {
        public let artist: String?
        public let title: String?
        public let album: String?
        public let timeTotal: Int?
        public let timeElapsed: Int?
        public let albumArt: String?
        public let artistArt: String?

        public init?(json: JSON) {
            self.artist = "artist" <~~ json
            self.title = "title" <~~ json
            self.album = "album" <~~ json
            self.timeTotal = "total" <~~ json
            self.timeElapsed = "elapsed" <~~ json
            self.albumArt = "albumArt" <~~ json
            self.artistArt = "artistArt" <~~ json
        }
    }
}
