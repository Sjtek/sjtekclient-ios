//
//  WebsocketTest.swift
//  Sjtek
//
//  Created by Wouter Habets on 10/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

// Unfortunately not working due a linking error with external websocket libraries(?)

//import Foundation
//import XCTest
//import SwiftWebSocket
//import Sjtek
//
//class WebsocketTest: XCTestCase {
//
//    func testUpdate() {
//        let websocket = WebSocket("ws://ws.sjtek.nl")
//        let asyncExpectation = expectation(description: "apiResponse")
//        var response: Sjtek.Response?
//        websocket.event.message = { message in
//            response = Response.from(string: message as! String)
//            asyncExpectation.fulfill()
//        }
//        
//        Sjtek.API.refresh()
//        
//        self.waitForExpectations(timeout: 5) { error in
//            XCTAssertNil(error, "Something went wrong")
//            XCTAssertNotNil(response)
//        }
//    }
//}
