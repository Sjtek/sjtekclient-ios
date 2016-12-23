//
//  Preferences.swift
//  Sjtek
//
//  Created by Wouter Habets on 15/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

/**
    Helper class for storing preferences in UserDefaults.
    */
class Preferences {
    
    private static let keyUsername = "username"
    private static let keyPassword = "password"
    private static let defaultUsername = "default"

    /**
        Username of the user. Will return "default" if not set.
        Use the set function to set this value.
        */
    static var username: String {
        if let storedUsername = getUserDefaults().string(forKey: keyUsername) {
            if !storedUsername.isEmpty {
                return storedUsername
            }
        }
        
        return defaultUsername
    }

    /**
        Password of the user.
        Use the set function to set this value.
        */
    static var password: String {
        if let password = getUserDefaults().string(forKey: keyPassword) {
            return password
        } else {
            return ""
        }
    }

    /**
        Set the username and password of the user.
        */
    static func set(username: String, password: String) {
        getUserDefaults().set(username, forKey: keyUsername)
        getUserDefaults().set(password, forKey: keyPassword)
    }

    /**
        Clear the credentials of the user.
        */
    static func clearCredentials() {
        set(username: "", password: "")
    }

    /**
        Check if the credentials are set.
        */
    static func areCredentialsSet() -> Bool {
        return !password.isEmpty
    }
    
    private static func getUserDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
}
