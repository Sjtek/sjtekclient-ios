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
    
    let user = "wouter"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        SwiftEventBus.onMainThread(self, name: APIResponseEvent.name()) {notification in
            let response = (notification.object as! APIResponseEvent).response
            self.update(response: response)
        }
        SwiftEventBus.onMainThread(self, name: APISettingsEvent.name()) {notification in
            let settings = (notification.object as! APISettingsEvent).settings
            self.update(settings: settings)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func update(response: Response) {
        light1.isOn = (response.lights?.light1)!
        light2.isOn = (response.lights?.light2)!
    }
    
    func update(settings: Settings) {
        let playlistSet = settings.users?[self.user]?.playlistSet
        let dataSource = PlaylistDataSource(playlistSet: playlistSet!)
        self.playlistCollectionView.dataSource = dataSource
        self.playlistCollectionView.delegate = dataSource
        self.playlistCollectionView.reloadData()
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
