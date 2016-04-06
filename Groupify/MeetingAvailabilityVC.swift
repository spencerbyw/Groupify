//
//  MeetingAvailabilityVC.swift
//  Groupify
//
//  Created by Spencer.Bywater on 4/5/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import Foundation
import UIKit

protocol MeetingAvailabilityVCDelegate {
    func updateData(data: (String, NSDate!))
}

class MeetingAvailabilityVC: UIViewController {
    @IBOutlet weak var meetingAddressField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var tempDate: NSDate!
    var tempAddress: String = ""
    
    var delegate: MeetingAvailabilityVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tempDate != nil {
            datePicker.setDate(tempDate, animated: true)
        }
        if tempAddress != "" {
            meetingAddressField.text! = tempAddress
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func doneClick(sender: AnyObject) {
        if meetingAddressField.text! == "" {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            self.delegate?.updateData((meetingAddressField.text!, datePicker.date))
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
}
