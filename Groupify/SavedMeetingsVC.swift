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

class SavedMeetingsVC: UIViewController, NSFetchedResultsControllerDelegate {
    
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var meetings: [Meeting]?

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
