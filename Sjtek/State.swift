//
//  State.swift
//  Sjtek
//
//  Created by Wouter Habets on 16/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation

class State {
    
    private static let keyResponse = "response"
    private static let keySettings = "settings"
    private static let keyDinner = "dinner"
    
    static let instance = State()
    
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
    
    private(set) var response: Response?
    private(set) var settings: Settings?
    var dinner: String?
    
    init() {
        load()
    }
    
    func save() {
        let userDefaults = getUserDefaults()
        userDefaults.set(responseJson, forKey: State.keyResponse)
        userDefaults.set(settingsJson, forKey: State.keySettings)
        userDefaults.set(dinner, forKey: State.keyDinner)
    }
    
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
