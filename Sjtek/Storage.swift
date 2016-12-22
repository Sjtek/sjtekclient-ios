//
//  Storage.swift
//  Sjtek
//
//  Created by Wouter Habets on 22/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

class Storage {
    
    private static let keyPlaylists = "storedPlaylists"
    private static let keyTempInside = "storedTempInside"
    private static let keyTempOutside = "storedTempOutside"
    
    static var playlists: [String]? {
        get {
            return getUserDefaults().stringArray(forKey: keyPlaylists)!
        }
        set(playlists) {
            getUserDefaults().set(playlists, forKey: keyPlaylists)
        }
    }
    
    static var tempInside: Int {
        get {
            return getUserDefaults().integer(forKey: keyTempInside)
        }
        set(temp) {
            getUserDefaults().set(temp, forKey: keyTempInside)
        }
    }
    
    static var tempOutside: Int {
        get {
            return getUserDefaults().integer(forKey: keyTempOutside)
        }
        set(temp) {
            getUserDefaults().set(temp, forKey: keyTempOutside)
        }
    }
    
    private static func getUserDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
}
