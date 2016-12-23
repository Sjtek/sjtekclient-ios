//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

/**
    Representing a registrated user in the API.
    */
public struct User: Decodable {
    /// Saved playlists of the user
    public let playlistSet: PlaylistSet?
    /// Should display extra light toggles
    public let checkExtraLight: Bool?
    /// Should inject Taylor Swift when starting a playlist
    public let injectTaylorSwift: Bool?
    /// Should automatically start the default playlist when pressing the master toggle button
    public let autoStartMusic: Bool?

    /// Nicknames that TTS should give to the user
    public let nickNames: [[String]]?
    /// Greetings for TTS
    public let greetings: [[String]]?
    /// Farewells for TTS
    public let farewells: [[String]]?

    public init?(json: JSON) {
        self.playlistSet = "playlistSet" <~~ json
        self.checkExtraLight = "checkExtraLight" <~~ json
        self.injectTaylorSwift = "injectTaylorSwift" <~~ json
        self.autoStartMusic = "autoStartMusic" <~~ json
        self.nickNames = "nickNames" <~~ json
        self.greetings = "greetings" <~~ json
        self.farewells = "farewells" <~~ json
    }
}
