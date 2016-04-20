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
    var timesAvailable = [String]()
    
    var namesDic = [String:String]()
    var placeDic = [String:String]()

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
        

        
        
        for each in members! {
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .ShortStyle
            print(each.meeting_availability_start)
            let time_available = String(formatter.stringFromDate(each.meeting_availability_start!))
            print(time_available)
            
            if !timesAvailable.contains(time_available) {
                timesAvailable.append(time_available)
                namesDic[String(time_available)] = each.name
                placeDic[String(time_available)] = each.preferred_meeting_location
                
            } else {
                //else add the name to the list of members available
                namesDic[String(time_available)] = namesDic[String(time_available)]! + " , " + each.name!
                placeDic[String(time_available)] = placeDic[String(time_available)]! + " : " + each.preferred_meeting_location!
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesAvailable.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as UITableViewCell
        cell2.textLabel?.text = timesAvailable[indexPath.row]
        return cell2
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "meeting_details" {
            if let viewController: ScheduleMeetingDetailsVC = segue.destinationViewController as? ScheduleMeetingDetailsVC {
                let selectedIndex: NSIndexPath = self.meetings_table.indexPathForCell(sender as! UITableViewCell)!
                
                viewController.date_time = timesAvailable[selectedIndex.row]
                viewController.groupName = selectedGroup?.name
                viewController.locations_available = placeDic[timesAvailable[selectedIndex.row]]
                viewController.members_available = namesDic[timesAvailable[selectedIndex.row]]
            }
        }
    }


}
