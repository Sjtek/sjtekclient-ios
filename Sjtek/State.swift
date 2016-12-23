//
//  State.swift
//  Sjtek
//
//  Created by Wouter Habets on 16/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

/**
    Helper for keeping the API state across app launches and extensions.
    */
class State {
    
    private static let keyResponse = "response"
    private static let keySettings = "settings"
    private static let keyDinner = "dinner"
    
    static let instance = State()

    /**
        JSON representation of the response object.
        */
    var responseJson: String? {
        didSet {
            if responseJson != nil {
                if !(responseJson?.isEmpty)! {
                    self.response = Response.from(string: responseJson!)
                    return
                }
            }
            self.response = nil
        }
    }

    /**
        JSON representaiton of the settings object.
        */
    var settingsJson: String? {
        didSet {
            if settingsJson != nil {
                if !(settingsJson?.isEmpty)! {
                    self.settings = Settings.from(string: settingsJson!)
                    return
                }
            }
            self.settings = nil
        }
    }

    /**
        State of the API.
        Generated when the JSON representation of this object is set.
        */
    private(set) var response: Response?

    /**
        Settings of the API.
        Generated when the JSON represention of this object is set.
        */
    private(set) var settings: Settings?

    /**
        Dinner sugestion.
        */
    var dinner: String?
    
    init() {
        load()
    }

    /**
        Save the state to UserDefaults.
        */
    func save() {
        let userDefaults = getUserDefaults()
        userDefaults.set(responseJson, forKey: State.keyResponse)
        userDefaults.set(settingsJson, forKey: State.keySettings)
        userDefaults.set(dinner, forKey: State.keyDinner)
    }

    /**
        Load the state from UserDefaults.
        */
    private func load() {
        let userDefaults = getUserDefaults()
        responseJson = userDefaults.string(forKey: State.keyResponse)
        settingsJson = userDefaults.string(forKey: State.keySettings)
        dinner = userDefaults.string(forKey: State.keyDinner)
    }
    
    private func getUserDefaults() -> UserDefaults {
        return UserDefaults(suiteName: "group.apidata")!
    }
}
