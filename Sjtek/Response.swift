//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct Response: Decodable {

    public let lights: Lights?
    public let music: Music?
    public let temperature: Temperature?
    public let nightmode: NightMode?

    public init?(json: JSON) {
        self.temperature = "temperature" <~~ json
        self.lights = "lights" <~~ json
        self.music = "music" <~~ json
        self.nightmode = "nightmode" <~~ json
    }
    
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
