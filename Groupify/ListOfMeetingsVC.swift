//
//  ListOfMeetingsVC.swift
//  Groupify
//
//  Created by Michael.Reichstein on 4/12/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ListOfMeetingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedGroup: Group?
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var groupMembers = [String]()
    var members: [Member]?
//    var timesAvailable: [Member]?
    @IBOutlet weak var meetings_table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest = NSFetchRequest(entityName: "Member")
        let predicate = NSPredicate(format: "group_name == %@", selectedGroup!.name!)
        fetchRequest.predicate = predicate
        
        do {
            let fetchResults = try self.context.executeFetchRequest(fetchRequest) as? [Member]
            members = fetchResults
        } catch {
            print("Error")
        }
//
//        for each in members! {
////            timesAvailable.append(each.meeting_availability_start)
//
//            
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as UITableViewCell
        
        cell2.textLabel?.text = String(members![indexPath.row].meeting_availability_start!)
        return cell2
    }

}
