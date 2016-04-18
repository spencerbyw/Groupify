//
//  ScheduleMeetingDetailsVC.swift
//  Groupify
//
//  Created by Michael.Reichstein on 4/17/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import UIKit

class ScheduleMeetingDetailsVC: UIViewController {
    
    var groupName: String?
    var date_time: String?
    var members_available: String?
    var locations_available: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(groupName)
        print(date_time)
        print(members_available)
        print(locations_available)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
