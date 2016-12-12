//
//  MusicWebViewController.swift
//  Sjtek
//
//  Created by Wouter Habets on 12/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit

class MusicWebViewController: UIViewController {
    
    let baseUrl = "http://music.sjtek.nl/musicbox_webclient/index.html#home"

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load(url: baseUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func load(url: String) {
        let url = URL (string: url);
        let requestObj = URLRequest(url: url!);
        webView.loadRequest(requestObj);
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
