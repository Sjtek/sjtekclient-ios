//
//  Arguments.swift
//  Sjtek
//
//  Created by Wouter Habets on 04/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

/**
    Representing arguments for the API.
    This class can build the full URL for the API.
    */
public class Arguments {

    /// Base URL of the API.
    static let baseUrl: String = "https://sjtek.nl/api"

    /// Action endpoint path
    let action: String

    /// Should use TTS at API level. Disabled by default.
    var useVoice: Bool
    /// User for the action. Set to the user "default" by default.
    var user: String
    /// Playlist to start when starting music. Empty by default.
    var playlist: String

    /**
        Create an arguments object with the refresh action.
        */
    init() {
        self.action = Action.refresh.path()
        self.useVoice = false
        self.user = ""
        self.playlist = ""
    }

    /**
        Create an arguments object with a custom action.
        */
    init(action: ActionPath) {
        self.action = action.path()
        self.useVoice = false
        self.user = ""
        self.playlist = ""
    }

    /**
        Build the full API url from the action and the arguments.
        */
    func build() -> String {
        var arguments = [String]()
        if (useVoice) {
            arguments.append("voice")
        }
        if (!user.isEmpty) {
            user = user.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            arguments.append("user=\(user)")
        } else {
            arguments.append("user=default")
        }
        if (!playlist.isEmpty) {
            playlist = playlist.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            arguments.append("url=\(playlist)")
        }

        let combinedArguments: String = "?" + arguments.joined(separator: "&")
        let url = "\(Arguments.baseUrl)\(action)\(combinedArguments)"
        return url
    }
}
