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

class ActionViewController: UIViewController {
    
    @IBOutlet weak var labelUri: UILabel!
    
    var uri: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier("public.url") {
                    provider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                        if let urlString = url as? String {
                            if let url = URL(string: urlString) {
                                let components = url.path.components(separatedBy: "/")
                                let type1 = components[1]
                                let id1 = components[2]
                                var uri = "spotify:\(type1):\(id1)"
                                if type1 == "user" {
                                    let type2 = components[3]
                                    let id2 = components[4]
                                    uri = "\(uri):\(type2):\(id2)"
                                }
                                self.uri = uri
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
        labelUri.text = "Invalid Spotify URL."
    }
    
    @IBAction func done() {
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
    
}
