//
//  StateTest.swift
//  Sjtek
//
//  Created by Wouter Habets on 16/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import XCTest
@testable import Sjtek

class StateTest: XCTestCase {
    
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
    
    func testEmptyState() {
        let state = State()
        XCTAssertNil(state.response)
        XCTAssertNil(state.settings)
    }
    
    func testResponseSet() {
        let json = TestData.exampleResponse
        let state = State()
        state.responseJson = json
        if let response: Response = state.response {
            XCTAssertEqual("The Wombats", response.music?.song?.artist)
            XCTAssert(!(response.lights?.light1)!)
        } else {
            XCTFail()
        }
    }
    
    func testSettingsSet() {
        let json = TestData.exampleData
        let state = State()
        state.settingsJson = json
        if let settings: Settings = state.settings {
            XCTAssert((settings.users?["wouter"]?.checkExtraLight)!)
        } else {
            XCTFail()
        }
    }
    
    func testResponseStore() {
        let json = TestData.exampleResponse
        var state = State()
        state.responseJson = json
        state.save()
        state = State()
        if let response: Response = state.response {
            XCTAssertEqual("The Wombats", response.music?.song?.artist)
            XCTAssert(!(response.lights?.light1)!)
        } else {
            XCTFail()
        }
    }
    
    func testSettingsStore() {
        let json = TestData.exampleData
        var state = State()
        state.settingsJson = json
        state.save()
        state = State()
        if let settings: Settings = state.settings {
            XCTAssert((settings.users?["wouter"]?.checkExtraLight)!)
            XCTAssertEqual("Opzich nog meer wel leuk", settings.users?["wouter"]?.playlistSet?.defaultPlaylist)
        } else {
            XCTFail()
        }
    }
}
