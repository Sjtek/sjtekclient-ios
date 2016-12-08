//
//  ArgumentsTest.swift
//  Sjtek
//
//  Created by Wouter Habets on 04/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import XCTest

@testable import Sjtek
class ArgumentsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildEmpty() {
        let expected = "https://sjtek.nl/api/info?user=default"
        let action: Action = Action.refresh
        let url = Arguments(action: action).build()
        XCTAssertEqual(url, expected)
    }
    
    func testBuildVoice() {
        let expected = "https://sjtek.nl/api/info?voice&user=default"
        let action: Action = Action.refresh
        let arguments = Arguments(action: action)
        arguments.useVoice = true
        let url = arguments.build()
        XCTAssertEqual(url, expected)
    }
    
    func testBuildUser() {
        let expected = "https://sjtek.nl/api/music/start?user=wouter"
        let action: Action.Music = Action.Music.start
        let arguments = Arguments(action: action)
        arguments.user = "wouter"
        let url = arguments.build()
        XCTAssertEqual(url, expected)
    }
    
    func testBuildUrl() {
        let expected = "https://sjtek.nl/api/music/start?user=default&url=spotify:track:4ZcGbQ5dOKX6rJk4yvza9R"
        let action: Action.Music = Action.Music.start
        let arguments = Arguments(action: action)
        arguments.playlist = "spotify:track:4ZcGbQ5dOKX6rJk4yvza9R"
        let url = arguments.build()
        XCTAssertEqual(url, expected)
    }
    
    func testBuildAll() {
        let expected = "https://sjtek.nl/api/music/start?voice&user=wouter&url=spotify:track:4ZcGbQ5dOKX6rJk4yvza9R"
        let action: Action.Music = Action.Music.start
        let arguments = Arguments(action: action)
        arguments.useVoice = true
        arguments.user = "wouter"
        arguments.playlist = "spotify:track:4ZcGbQ5dOKX6rJk4yvza9R"
        let url = arguments.build()
        XCTAssertEqual(url, expected)
    }
}
