//
//  API.swift
//  Sjtek
//
//  Created by Wouter Habets on 07/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftEventBus
import Gloss

public class API {
    
    public static func refresh() {
        send(arguments: Arguments())
    }
    
    public static func send(action: ActionPath) {
        send(arguments: Arguments(action: action))
    }
    
    public static func send(arguments: Arguments) {
        Alamofire.request(arguments.build(), method: .post, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200, 201:
                        if let result = response.result.value {
                            let JSON = result as! JSON
                            let response = Response(json: JSON)
                            Bus.post(APIResponseEvent(response!))
                        }
                    default:
                        Bus.post(APIErrorEvent(code: status))
                    }
                }
        }

    }
    
    public static func data() {
        let url = Arguments.baseUrl + Action.data.path()
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200, 201:
                        if let result = response.result.value {
                            let JSON = result as! JSON
                            let settings = Settings(json: JSON)
                            Bus.post(APISettingsEvent(settings: settings!))
                        }
                    default:
                        Bus.post(APIErrorEvent(code: status))
                    }
                }
        }
        
    }
}
