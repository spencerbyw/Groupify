//
//  ScheduleAMeetingVC.swift
//  Groupify
//
//  Created by Michael.Reichstein on 4/8/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ScheduleAMeetingVC: UIViewController, NSFetchedResultsControllerDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var groupTable: UITableView!
    var deleteGroupIndexPath: NSIndexPath? = nil

    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var nItem:Group? = nil
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    var temp_group:Group? = nil
    
    func getFetchResultsController() -> NSFetchedResultsController {
        dataViewController = NSFetchedResultsController(fetchRequest: getFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return dataViewController
    }
    
    func getFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Group")
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTable.dataSource = self
        dataViewController = getFetchResultsController()
        dataViewController.delegate = self
        do {
            try dataViewController.performFetch()
            print("Group fetch performed (\(dataViewController.fetchedObjects!.count) objects)")
        } catch _ {
            print("Group list could not be fetched.")
        }
        groupTable.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.groupTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewController.fetchedObjects!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.groupTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let groupInfo = dataViewController.objectAtIndexPath(indexPath) as! Group
        let name = groupInfo.name
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func confirmDelete(group: String) {
        let alert = UIAlertController(title: "Delete Group", message: "Are you sure you want to permanently delete \(group)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteGroup)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteGroup)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteGroup(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteGroupIndexPath {
            groupTable.beginUpdates()
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            groupTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            deleteGroupIndexPath = nil
            groupTable.endUpdates()
        }
    }
    
    func cancelDeleteGroup(alertAction: UIAlertAction!) {
        deleteGroupIndexPath = nil
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Group
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
    

}


