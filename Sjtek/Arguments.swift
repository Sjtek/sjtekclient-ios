//
//  Arguments.swift
//  Sjtek
//
//  Created by Wouter Habets on 04/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//


public class Arguments {

    let baseUrl: String = "https://sjtek.nl/api"

    let action: String

    var useVoice: Bool
    var user: String
    var playlist: String
    
    init(action: ActionPath) {
        self.action = action.path()
        self.useVoice = false
        self.user = ""
        self.playlist = ""
    }

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
        let url = "\(baseUrl)\(action)\(combinedArguments)"
        return url
    }
}
