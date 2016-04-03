//
//  ManageGroupsVC.swift
//  Groupify
//
//  Created by Spencer.Bywater on 3/31/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ManageGroupsVC: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var deleteMemberIndexPath: NSIndexPath? = nil
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var nItem:Member? = nil
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    var temp_member:Member? = nil
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        dataViewController = NSFetchedResultsController(fetchRequest: getFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return dataViewController
        
    }
    
    func getFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "Member")
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataViewController = getFetchResultsController()
        
        dataViewController.delegate = self
        do {
            try dataViewController.performFetch()
        } catch _ {
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewController.fetchedObjects!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let memberInfo = dataViewController.objectAtIndexPath(indexPath) as! Member
        let name = memberInfo.name
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func confirmDelete(place: String) {
        let alert = UIAlertController(title: "Delete Place", message: "Are you sure you want to permanently delete \(place)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeletePlace)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeletePlace)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeletePlace(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteMemberIndexPath {
            tableView.beginUpdates()
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            deleteMemberIndexPath = nil
            
            tableView.endUpdates()
        }
    }
    
    func cancelDeletePlace(alertAction: UIAlertAction!) {
        deleteMemberIndexPath = nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            if let viewController: MemberInfoVC = segue.destinationViewController as? MemberInfoVC {
                let selectedIndex: NSIndexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)!
                let place = dataViewController.fetchedObjects![selectedIndex.row]
                viewController.selectedMember = place as? Member;
                viewController.addSegue = false
                
            }
        } else if segue.identifier == "addSegue" {
            if let viewController: MemberInfoVC = segue.destinationViewController as? MemberInfoVC {
                viewController.addSegue = true
                viewController.context = self.context
            }
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Member
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }

    
}
