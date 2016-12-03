//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct User: Decodable {
    public let playlistSet: PlaylistSet?
    public let checkExtraLight: Bool?
    public let injectTaylorSwift: Bool?
    public let autoStartMusic: Bool?

    public let nickNames: [[String]]?
    public let greetings: [[String]]?
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
