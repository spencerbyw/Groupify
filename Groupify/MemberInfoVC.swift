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

class MemberInfoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupNumber: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var imgBox: UIImageView!
    @IBOutlet var mainView: UIView!
    
    
    var selectedMember: Member?
    var addSegue: Bool = false
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var desiredDate: NSDate!
    var desiredAddress: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if addSegue == false {
            setupMemberInterface()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupMemberInterface() {
        nameField.text = selectedMember!.name
        phoneField.text = selectedMember!.phone
        emailField.text = selectedMember!.email
        groupName.text = selectedMember!.group_name
        groupNumber.text = selectedMember!.group_number
        addressField.text = selectedMember!.address
        if selectedMember!.profile_picture != nil {
            let temp_img_data = selectedMember!.profile_picture! as NSData
            imgBox.image = UIImage(data: temp_img_data, scale: 1.0)
        }
        
        desiredDate = selectedMember!.meeting_availability_start
        desiredAddress = selectedMember!.preferred_meeting_location!
    }
    
    @IBAction func saveMemberInfo(sender: AnyObject) {
        // If a field is empty display an alert
        if (nameField.text!.isEmpty
            || phoneField.text!.isEmpty
            || emailField.text!.isEmpty
            || groupName.text!.isEmpty
            || groupNumber.text!.isEmpty
            || addressField.text!.isEmpty)
        {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (desiredDate == nil || desiredAddress == "") {
            let alert = UIAlertController(title: "Error", message: "Please pick a time and place that you would be able to meet.", preferredStyle: UIAlertControllerStyle.Alert)
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
                nItem.preferred_meeting_location = desiredAddress
                nItem.meeting_availability_start = desiredDate
                
                do {
                    try context.save()
                } catch _ {
                    print("Error saving Member details.")
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
                }
                nItem!.preferred_meeting_location = desiredAddress
                nItem!.meeting_availability_start = desiredDate
                do {
                    try context.save()
                } catch _ {
                }
                
            }
            navigationController!.popViewControllerAnimated(true)
        }
        
        
        
    }
    
    @IBAction func pickProfilePicture(sender: AnyObject) {
        var photoPicker = UIImagePickerController ()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        // display image selection view
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    @IBAction func addMeetingAvailability(sender: AnyObject) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        imgBox.image = image
        
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        self.mainView.resignFirstResponder()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMA" {
            if let viewController: MeetingAvailabilityVC = segue.destinationViewController as? MeetingAvailabilityVC {
                if desiredDate != nil {
                    viewController.tempDate = desiredDate
                }
                if desiredAddress != "" {
                    viewController.tempAddress = desiredAddress
                }
                (segue.destinationViewController as! MeetingAvailabilityVC).delegate = self
            }
        }
    }

    
    
}

extension MemberInfoVC: MeetingAvailabilityVCDelegate {
    func updateData(data: (String, NSDate!)) {
        desiredAddress = data.0
        desiredDate = data.1
    }
}