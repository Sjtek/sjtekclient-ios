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
        let data = TestData.exampleData.data(using: String.Encoding.utf8)!
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, Any>
            guard let settings = Settings(json: json!) else {
                XCTAssert(false, "Parsing failed")
                return
            }
            
            XCTAssert((settings.users?["wouter"]?.checkExtraLight)!)
        } catch _ {
            
        }
    }
    
    func testResponse() {
        let data = TestData.exampleResponse.data(using: String.Encoding.utf8)!
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, Any>
            guard let response = Response(json: json!) else {
                XCTAssert(false, "Parsing failed")
                return
            }
            
            XCTAssertEqual(response.music?.song?.artist, "The Wombats")
            XCTAssertEqual(response.lights?.light1, false)
//            XCTAssertEqual(response.temperature?.inside, 20.0)
        } catch _ {
            
        }
    }
}
