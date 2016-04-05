//
//  MemberInfoVC.swift
//  Groupify
//
//  Created by Spencer.Bywater on 4/2/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MemberInfoVC: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupNumber: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var imgBox: UIImageView!
    
    
    var selectedMember: Member?
    var addSegue: Bool = false
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveMemberInfo(sender: AnyObject) {
        // If a field is empty display an alert
        if (nameField.text!.isEmpty || phoneField.text!.isEmpty || emailField.text!.isEmpty || groupName.text!.isEmpty || groupNumber.text!.isEmpty || addressField.text!.isEmpty) {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        // Otherwise, continue saving
        else {
            if addSegue == true {
                // Save new item to DB
                let context = self.context
                let ent = NSEntityDescription.entityForName("Member", inManagedObjectContext: context)
                let nItem = Member(entity: ent!, insertIntoManagedObjectContext: context)
                
                nItem.name = nameField.text
                nItem.phone = phoneField.text
                nItem.email = emailField.text
                nItem.group_name = groupName.text
                nItem.group_number = groupNumber.text
                nItem.address = addressField.text
                if (imgBox.image != nil) {
                    let new_img = imgBox.image
                    let new_img_data = UIImageJPEGRepresentation(new_img!, 1)
                    nItem.profile_picture = new_img_data
                }

                // STILL LACKING SELECTED MEETING TIME
                
                do {
                    print("here!")
                    try context.save()
                } catch _ {
                    print("ruh roh")
                }
            }
            else if addSegue == false {
                // Update item in DB
                let context = self.context
                var nItem = selectedMember
                
                nItem!.name = nameField.text
                nItem!.phone = phoneField.text
                nItem!.email = emailField.text
                nItem!.group_name = groupName.text
                nItem!.group_number = groupNumber.text
                nItem!.address = addressField.text
                if (imgBox.image != nil) {
                    let new_img = imgBox.image
                    let new_img_data = UIImageJPEGRepresentation(new_img!, 1)
                    nItem!.profile_picture = new_img_data
                }                // STILL LACKING SELECTED MEETING TIME
                
                do {
                    try context.save()
                } catch _ {
                }
                
            }
            navigationController!.popViewControllerAnimated(true)
        }
        
        
        
    }
    
    
}