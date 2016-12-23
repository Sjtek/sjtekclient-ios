//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

/**
    Collection of the states of different modules of the API.
    */
public struct Response: Decodable {

    /// The lights module state
    public let lights: Lights?
    /// The music module state
    public let music: Music?
    /// The Temperature module state
    public let temperature: Temperature?
    /// The night mode state
    public let nightmode: NightMode?
    /// The coffee machine state
    public let coffee: Coffee?

    public init?(json: JSON) {
        self.temperature = "temperature" <~~ json
        self.lights = "lights" <~~ json
        self.music = "music" <~~ json
        self.nightmode = "nightmode" <~~ json
        self.coffee = "coffee" <~~ json
    }

    /**
        Create a response object from a JSON string.
            - Parameters:
                - string: JSON string to parse
        */
    public static func from(string: String) -> Response? {
        do {
            let data = string.data(using: String.Encoding.utf8)!
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, Any>
            return Response(json: json!)
        } catch _ {
            return nil
        }
    }
}
