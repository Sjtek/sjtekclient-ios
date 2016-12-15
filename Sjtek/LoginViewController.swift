//
//  LoginViewController.swift
//  Sjtek
//
//  Created by Wouter Habets on 15/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit
import SwiftEventBus

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var loadingView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftEventBus.onMainThread(self, name: APISettingsEvent.name()) {notification in
            let settings = (notification.object as! APISettingsEvent).settings
            if (settings.users?[Preferences.username]) != nil {
                self.loginSuccessful()
            } else {
                self.showDialog(error: Error.unknownUser)
            }
        }
        SwiftEventBus.onMainThread(self, name: APIErrorEvent.name()) {notification in
            self.showDialog(error: Error.authentication)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSignInClick(_ sender: UIButton) {
        if let username = textFieldUsername.text {
            if let password = textFieldPassword.text {
                Preferences.set(username: username, password: password)
                API.data()
            } else {
                showDialog(error: Error.username)
            }
        } else {
            showDialog(error: Error.password)
        }
    }
    
    func showLoadingView() {
        loadingView?.removeFromSuperview()
        loadingView = UIView(frame: view.frame)
        loadingView?.backgroundColor = UIColor.black
        loadingView?.alpha = 0.8
        view.addSubview(loadingView!)
    }
    
    func showDialog(error: Error) {
        loadingView?.removeFromSuperview()
        let alert = UIAlertController(title: "Oops, could not login", message: error.rawValue, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loginSuccessful() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    enum Error: String {
        case username = "Invalid username."
        case password = "Invalid password."
        case authentication = "Invalid credentials. Please try again."
        case unknownUser = "Authentication successful. But settings could not be loaded"
    }
}
