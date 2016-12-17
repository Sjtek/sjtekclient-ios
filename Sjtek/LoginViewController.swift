//
//  LoginViewController.swift
//  Sjtek
//
//  Created by Wouter Habets on 15/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit
import SwiftEventBus

class LoginViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelAccount: UILabel!
    @IBOutlet weak var labelSignIn: UILabel!
    @IBOutlet weak var cellUsername: UITableViewCell!
    @IBOutlet weak var cellPassword: UITableViewCell!
    
    var loadingView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
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
    
    func updateViews() {
        if Preferences.areCredentialsSet() {
            let name = Preferences.username
            labelAccount.text = "Signed in as " + name.capitalized
            cellUsername.isHidden = true
            cellPassword.isHidden = true
            labelSignIn.text = "Sign Out"
        } else {
            labelAccount.text = "Signed out"
            cellUsername.isHidden = false
            cellPassword.isHidden = false
            labelSignIn.text = "Sign In"
        }
    }
    
    func onSignInClick() {
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
    
    func onSignOutClick() {
        Preferences.clearCredentials()
        updateViews()
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
        updateViews()
    }
    
    func deselectCells() {
        if let selected = tableView.indexPathsForSelectedRows {
            for cell in selected {
                tableView.deselectRow(at: cell, animated: true)
            }
        }
    }
    
    enum Error: String {
        case username = "Invalid username."
        case password = "Invalid password."
        case authentication = "Invalid credentials. Please try again."
        case unknownUser = "Authentication successful. But settings could not be loaded"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        if indexPath.section == 2 && indexPath.row == 0 {
            if Preferences.areCredentialsSet() {
                onSignOutClick()
                deselectCells()
            } else {
                onSignInClick()
                deselectCells()
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldUsername {
            textFieldPassword.becomeFirstResponder()
        } else if textField == textFieldPassword {
            textField.resignFirstResponder()
            onSignInClick()
        }
        return true
    }
}
