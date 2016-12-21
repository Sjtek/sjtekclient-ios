//
//  TodayViewController.swift
//  SjtekWidget
//
//  Created by Wouter Habets on 21/12/2016.
//  Copyright © 2016 Sjtek. All rights reserved.
//

import UIKit
import NotificationCenter
import Sjtek

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var newDinner: String?
    
    @IBOutlet weak var labelDinner: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDinner.text = newDinner
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        let newDinner = UserDefaults(suiteName: "group.apidata")?.string(forKey: "dinner")
        if newDinner == labelDinner.text {
            
            completionHandler(NCUpdateResult.noData)
        } else {
            self.newDinner = newDinner
            self.labelDinner.text = newDinner
            completionHandler(NCUpdateResult.newData)
        }
        
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        
    }
    
}
