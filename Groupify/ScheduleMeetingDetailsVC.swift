//
//  ScheduleMeetingDetailsVC.swift
//  Groupify
//
//  Created by Michael.Reichstein on 4/17/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import UIKit
import CoreData

class ScheduleMeetingDetailsVC: UIViewController {
    
    var groupName: String?
    var date_time: String?
    var members_available: String?
    var locations_available: String?
    
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var metingDateTimeLabel: UILabel!
    @IBOutlet weak var availableMemberBox: UITextView!
    @IBOutlet weak var locationsBox: UITextView!
    
    
    @IBAction func Schedule_Meeting_button(sender: AnyObject) {
        let context = self.context
        let ent = NSEntityDescription.entityForName("Meeting", inManagedObjectContext: context)
        
        let nItem = Meeting(entity: ent!, insertIntoManagedObjectContext: context)
        
        
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupNameLabel.text = groupName
        metingDateTimeLabel.text = date_time
        availableMemberBox.text = members_available
        locationsBox.text = locations_available
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
