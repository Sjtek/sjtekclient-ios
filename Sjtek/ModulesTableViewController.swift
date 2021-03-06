//
//  ModulesTableViewController.swift
//  Sjtek
//
//  Created by Wouter Habets on 10/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit
import SwiftEventBus

class ModulesTableViewController: UITableViewController {

    @IBOutlet weak var buttonToggle: UIButton!
    @IBOutlet weak var light1: UISwitch!
    @IBOutlet weak var light2: UISwitch!
    @IBOutlet weak var playlistCollectionView: UICollectionView!
    @IBOutlet weak var labelHome: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCoffee: UILabel!
    @IBOutlet weak var labelTempIn: UILabel!
    @IBOutlet weak var labelTempOut: UILabel!
    @IBOutlet weak var labelTempDescription: UILabel!
    @IBOutlet weak var labelDinner: UILabel!
    
    var playlistDataSource = PlaylistDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Preferences.areCredentialsSet() {
            labelHome.alpha = 0
            labelName.alpha = 1
            labelName.text = "Welcome \(Preferences.username.capitalized)"
        }
        
        if let response = State.instance.response {
            update(response: response)
        }
        if let settings = State.instance.settings {
            update(settings: settings)
        }
        
        registerEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Preferences.areCredentialsSet() {
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut, animations: {
                self.labelName.alpha = 0
                self.labelHome.alpha = 1
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        unregisterEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerEvents() {
        SwiftEventBus.onMainThread(self, name: APIResponseEvent.name()) {notification in
            let response = (notification.object as! APIResponseEvent).response
            self.update(response: response)
        }
        SwiftEventBus.onMainThread(self, name: APISettingsEvent.name()) {notification in
            let settings = (notification.object as! APISettingsEvent).settings
            self.update(settings: settings)
        }
        SwiftEventBus.onMainThread(self, name: APIMealEvent.name()) {notification in
            let meal = (notification.object as! APIMealEvent).meal
            self.update(meal: meal)
            
        }
    }
    
    func unregisterEvents() {
        SwiftEventBus.unregister(self)
    }
    
    @IBAction func onToggleClick(_ sender: UIButton) {
        API.send(action: Action.toggle)
    }
    
    @IBAction func onLight1Click(_ sender: Any) {
        API.send(action: Action.Lights.toggle1)
    }
    @IBAction func onToggle2Click(_ sender: Any) {
        API.send(action: Action.Lights.toggle2)
    }
    
    @IBAction func onCoffeeClick(_ sender: Any) {
        API.send(action: Action.Coffee.start)
    }
    
    @IBAction func onDinnerRefreshClick(_ sender: Any) {
        API.meal()
    }
    
    func update(response: Response) {
        light1.isOn = (response.lights?.light1)!
        light2.isOn = (response.lights?.light2)!
        labelCoffee.text = (response.coffee?.heated)! ? "Heated" : "Cold"
        labelTempIn.text = "\(Int((response.temperature?.inside)!))"
        labelTempOut.text = "\(Int((response.temperature?.outside)!))"
        labelTempDescription.text = response.temperature?.description
    }
    
    func update(settings: Settings) {
        let playlistSet = settings.users?[Preferences.username]?.playlistSet
        playlistDataSource = PlaylistDataSource(playlistSet: playlistSet!)
        self.playlistCollectionView.dataSource = playlistDataSource
        self.playlistCollectionView.delegate = playlistDataSource
        self.playlistCollectionView.reloadData()
    }
    
    func update(meal: Meal) {
        labelDinner.text = meal.name
    }

    func addTopSeparator() {
        self.tableView.tableFooterView = UIView()
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: px)
        let line = UIView(frame: frame)
        self.tableView.tableHeaderView = line
        line.backgroundColor = self.tableView.separatorColor
    }
}
