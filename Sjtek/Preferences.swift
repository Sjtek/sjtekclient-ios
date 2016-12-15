//
//  Preferences.swift
//  Sjtek
//
//  Created by Wouter Habets on 15/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

class Preferences {
    
    private static let keyUsername = "username"
    private static let keyPassword = "password"
    private static let defaultUsername = "default"
    
    static var username: String {
        if let storedUsername = getUserDefaults().string(forKey: keyUsername) {
            if !storedUsername.isEmpty {
                return storedUsername
            }
        }
        
        return defaultUsername
    }
    
    static var password: String {
        if let password = getUserDefaults().string(forKey: keyPassword) {
            return password
        } else {
            return ""
        }
    }
    
    static func set(username: String, password: String) {
        getUserDefaults().set(username, forKey: keyUsername)
        getUserDefaults().set(password, forKey: keyPassword)
    }
    
    static func clearCredentials() {
        set(username: "", password: "")
    }
    
    static func areCredentialsSet() -> Bool {
        return !password.isEmpty
    }
    
    private static func getUserDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
}
