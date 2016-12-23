//
//  ActionViewController.swift
//  SjtekAction
//
//  Created by Wouter Habets on 21/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire

/**
    ViewController for starting a shared url on Sjtek.
    */
class ActionViewController: UIViewController {
    
    @IBOutlet weak var labelUri: UILabel!
    
    var uri: String = ""
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier("public.url") {
                    // Here we request the url
                    provider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                        // Callback when the url has been received.

                        // Parse the data to an Url object
                        if let url = self.parse(data: url) {
                            self.url = url

                            // Convert the url to a Spotify URI.
                            if let uri = self.parse(url: url) {
                                self.uri = uri

                                // Update the UI and start the URI
                                DispatchQueue.main.async {
                                    self.start()
                                }
                                return
                            }
                        }
                        DispatchQueue.main.async {
                            self.displayError()
                        }
                    })
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /**
        Parse the data to an URL.
        Spotify will return a String, Safari will return NSURL.
        */
    func parse(data: NSSecureCoding?) -> URL? {
        guard data != nil else {
            return nil
        }
        if let url = data as? NSURL {
            return url as URL
        } else if let urlString = data as? String {
            return URL(string: urlString)
        } else {
            return nil
        }
    }

    /**
        Parse the URL to a Spotify URI.
        */
    func parse(url: URL) -> String? {
        // Only Spotify URLs are allowed.
        guard url.host == "open.spotify.com" else {
            return nil
        }

        // The path should at least contain two components. But can be more.
        guard url.pathComponents.count > 2 else {
            return nil
        }
        
        let components = url.pathComponents
        // This is the type of the data. Could be an album, artist or track.
        let type1 = components[1]
        // Id of the type
        let id1 = components[2]
        // Generate the first (or last) part of the URI
        var uri = "spotify:\(type1):\(id1)"

        // If the URL contains a playlist, the type is user and we should continue parsing.
        if type1 == "user" {
            // Second type. Usually playlist.
            let type2 = components[3]
            // Id of the type.
            let id2 = components[4]
            // Append the new data to the URI
            uri = "\(uri):\(type2):\(id2)"
        }
        return uri
    }

    /**
        The url was valid. Start it.
        */
    func start() {
        labelUri.text = uri
        let arguments = Arguments(action: Action.Music.start)
        arguments.playlist = uri
        Alamofire.request(arguments.build(), method: .get, parameters: nil, encoding: JSONEncoding.default).responseString { response in
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200, 201:
                    break
                default:
                    break;
                }
            }
        }
        
    }
    
    func displayError() {
        labelUri.text = "Invalid Spotify URL.\n\nUrl:\n\(url)"
    }
    
    @IBAction func done() {
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
    
}
