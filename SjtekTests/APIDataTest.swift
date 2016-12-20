//
//  APIDataTest.swift
//  Sjtek
//
//  Created by Wouter Habets on 01/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import XCTest
import Sjtek

class APIDataTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSettings() {
        let json = TestData.exampleData
        guard let settings = Settings.from(string: json) else {
            XCTAssert(false, "Parsing failed")
            return
        }

        XCTAssert((settings.users?["wouter"]?.checkExtraLight)!)
    }

    func testResponse() {

        let json = TestData.exampleResponse
        guard let response = Response.from(string: json) else {
            XCTAssert(false, "Parsing failed")
            return
        }

        XCTAssertEqual(response.music?.song?.artist, "The Wombats")
        XCTAssertEqual(response.lights?.light1, false)
        XCTAssertEqual(response.temperature?.inside, 20.0)
    }
}
