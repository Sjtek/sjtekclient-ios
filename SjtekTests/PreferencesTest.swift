//
//  PreferencesTest.swift
//  Sjtek
//
//  Created by Wouter Habets on 15/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import XCTest
@testable import Sjtek

class PreferencesTest: XCTestCase {
    
    let defaultUsername = "default"
    
    func clear() {
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
    }
    
    override func setUp() {
        clear()
    }
    
    override func tearDown() {
        clear()
    }
    
    func testEmptyCredentials() {
        XCTAssertEqual(defaultUsername, Preferences.username)
        XCTAssertEqual("", Preferences.password)
        XCTAssert(!Preferences.areCredentialsSet())
    }
    
    func testSetCredentials() {
        let username = "testuser"
        let password = "testpassword"
        Preferences.set(username: username, password: password)
        XCTAssertEqual(username, Preferences.username)
        XCTAssertEqual(password, Preferences.password)
    }
    
    func testClearCredentials() {
        let username = "testuser"
        let password = "testpassword"
        Preferences.set(username: username, password: password)
        Preferences.clearCredentials()
        XCTAssertEqual(defaultUsername, Preferences.username)
        XCTAssertEqual("", Preferences.password)
    }
    
    func testCredentialsCheck() {
        let username = "testuser"
        let password = "testpassword"
        Preferences.set(username: username, password: password)
        XCTAssert(Preferences.areCredentialsSet())
        Preferences.clearCredentials()
        XCTAssert(!Preferences.areCredentialsSet())
    }
}
