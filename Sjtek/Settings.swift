//
// Created by Wouter Habets on 01/12/2016.
// Copyright (c) 2016 Sjtek. All rights reserved.
//

import Foundation
import Gloss

/**
    Collection of settings from the API.
    */
public struct Settings: Decodable {
    /// Set of users regsitrated at the API
    public let users: Dictionary<String, User>?
    /// Various things we sometimes say
    public let quotes: [String]?

    public init?(json: JSON) {
        self.users = "users" <~~ json
        self.quotes = "quotes" <~~ json
    }

    /**
        Create a settings object from a JSON string.
            - Parameters:
                - string: JSON string to parse
        */
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
