//
//  ScheduleMeetingDetailsVC.swift
//  Groupify
//
//  Created by Michael.Reichstein on 4/17/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import MapKit

class ScheduleMeetingDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var groupName: String?
    var date_time: String?
    var members_available: String?
    var locations_available: String?
    var place_list: [String]?
    var selected_place: String?
    
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    
    @IBOutlet weak var mapBox: MKMapView!
    @IBOutlet weak var placePicker: UIPickerView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var metingDateTimeLabel: UILabel!
    @IBOutlet weak var availableMemberBox: UITextView!
    
    @IBAction func Schedule_Meeting(sender: AnyObject) {
                let context = self.context
                let ent = NSEntityDescription.entityForName("Meeting", inManagedObjectContext: context)
        
                let nItem = Meeting(entity: ent!, insertIntoManagedObjectContext: context)
        
        
                nItem.date_time = date_time
                nItem.group_name = groupName
                nItem.members_available = members_available
                nItem.places = selected_place
        
                do {
                    try context.save()
                } catch _ {
                    print("Error saving Member details.")
                }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !(place_list?.isEmpty)! {
            getDirections(place_list![0])
        }
        placePicker.dataSource = self
        placePicker.delegate = self
        print(place_list)

        groupNameLabel.text = groupName
        metingDateTimeLabel.text = date_time
        availableMemberBox.text = members_available
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return place_list!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return place_list![row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_place = place_list![row]
        getDirections(selected_place!)
    }
    
    func getDirections(sender: AnyObject) {
        let address = ( sender as! NSString)
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString (address as String, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if let placemark = placemarks?[0]  {
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.mapBox.setRegion(region, animated: true)
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                ani.title = address as String
                
                self.mapBox.addAnnotation(ani)
            }
        })
    }

}
