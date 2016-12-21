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
        let request = Alamofire.request(arguments.build(), method: .post, parameters: nil, encoding: JSONEncoding.default)
        if Preferences.areCredentialsSet() {
            request.authenticate(user: Preferences.username, password: Preferences.password)
        }
        request.responseString { response in
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200, 201:
                        if let result = response.result.value {
                            let response = Response.from(string: result)
                            State.instance.responseJson = result
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
        let request = Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default)
        if Preferences.areCredentialsSet() {
            request.authenticate(user: Preferences.username, password: Preferences.password)
        }
        request.responseString { response in
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200, 201:
                        if let result = response.result.value {
                            let settings = Settings.from(string: result)
                            State.instance.settingsJson = result
                            Bus.post(APISettingsEvent(settings: settings!))
                        }
                    default:
                        Bus.post(APIErrorEvent(code: status))
                    }
                }
        }
        
    }
    
    public static func meal() {
        let url = "https://sjtekfood.habets.io/api/dinners/next"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                if let status = response.response?.statusCode {
                    switch status {
                    case 200, 201:
                        if let result = response.result.value {
                            if let meal = Meal(json: result as! JSON) {
                                State.instance.dinner = meal.name
                                Bus.post(APIMealEvent(meal))
                            }
                        }
                    default:
                        break
                    }
                }
        }
    }
}
