//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

public struct Settings: Decodable {
    public let users: Dictionary<String, User>?
    public let quotes: [String]?

    public init?(json: JSON) {
        self.users = "users" <~~ json
        self.quotes = "quotes" <~~ json
    }
    
    public static func from(string: String) -> Settings? {
        do {
            let data = string.data(using: String.Encoding.utf8)!
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, Any>
            return Settings(json: json!)
        } catch _ {
            return nil
        }
    }
}
