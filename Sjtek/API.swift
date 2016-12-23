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

/**
    This class provides communication with the API.
    All responses from the API are returned with SwiftEventBus.
*/
public class API {

    /**
        Get the latest state form the API.
    */
    public static func refresh() {
        send(arguments: Arguments())
    }

    /**
        Send an Action to the API.
        This will be wrapped in a Arguments object.
        */
    public static func send(action: ActionPath) {
        send(arguments: Arguments(action: action))
    }

    /**
        Send an Action with Argument to the API.
        */
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

    /**
        Get the settings of the API.
        */
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

    /**
        Get a meal suggestion.
        */
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
