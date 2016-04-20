//
//  SavedMeetingsVC.swift
//  Groupify
//
//  Created by Michael.Reichstein on 4/19/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SavedMeetingsVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var meetings: [Meeting]?

    var deleteMeetingIndexPath: NSIndexPath? = nil

    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchResultsController() -> NSFetchedResultsController {
        dataViewController = NSFetchedResultsController(fetchRequest: getFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return dataViewController
    }
    
    func getFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Meeting")
        let sortDescripter = NSSortDescriptor(key: "date_time", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataViewController = getFetchResultsController()
        dataViewController.delegate = self
        do {
            try dataViewController.performFetch()
            print("Meeting fetch performed (\(dataViewController.fetchedObjects!.count) objects)")
        } catch _ {
            print("Meeting list could not be fetched.")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewController.fetchedObjects!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let meetingInfo = dataViewController.objectAtIndexPath(indexPath) as! Meeting
        let date_time = meetingInfo.date_time
        cell.textLabel?.text = date_time
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func confirmDelete(meeting: String) {
        let alert = UIAlertController(title: "Delete Meeting", message: "Are you sure you want to permanently delete \(meeting)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteMeeting)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteMeeting)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteMeeting(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteMeetingIndexPath {
            tableView.beginUpdates()
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            deleteMeetingIndexPath = nil
            
            tableView.endUpdates()
        }
    }
    
    func cancelDeleteMeeting(alertAction: UIAlertAction!) {
        deleteMeetingIndexPath = nil
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Meeting
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
