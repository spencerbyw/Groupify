//
//  MeetingDetailsVC.swift
//  Groupify
//
//  Created by Spencer.Bywater on 4/22/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

class MeetingDetailsVC: UIViewController {
    var mtg: Meeting?
    var lat:String = ""
    var lon:String = ""
    var coord:CLLocationCoordinate2D?
    var fmt_date:String = ""
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var mtgDateLabel: UILabel!
    @IBOutlet weak var membsAvailableLabel: UITextView!
    @IBOutlet weak var weatherDetailsLabel: UITextView!
    @IBOutlet weak var mapBox: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        fmt_date = formatter.stringFromDate(mtg!.real_date!)
        print(fmt_date)
        
        groupNameLabel.text? = mtg!.group_name!
        mtgDateLabel.text? = mtg!.date_time!
        membsAvailableLabel.text = mtg!.members_available!
        locationLabel.text? = mtg!.places!
        getDirections(mtg!.places!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func clickDelete(sender: AnyObject) {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
    }
    
    func getDirections(sender: AnyObject) {
        print("calling getDirections")
        let address = ( sender as! NSString)
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString (address as String, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if let placemark = placemarks?[0]  {
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.mapBox.setRegion(region, animated: true)
                let ani = MKPointAnnotation()
                self.coord = ani.coordinate
                ani.coordinate = placemark.location!.coordinate
                ani.title = address as String
                self.mapBox.addAnnotation(ani)
                self.lon = String(ani.coordinate.latitude)
                self.lat = String(ani.coordinate.longitude)

                dispatch_async(dispatch_get_main_queue(), {
                    print("JSON call?:")
                    self.getWeatherJson()
                })
                print(self.lat)
                print(self.lon)
            }
        })
    }
    
    // http://api.openweathermap.org/data/2.5/forecast?lat=-35.233223&lon=39.093405&units=imperial&appid=b6a54ede1934dcbfd07f2a127bcba765
    
    func retrieveEarthquakeInfo() {
        view.endEditing(true)
        if !mtg!.places!.isEmpty {
            weatherDetailsLabel.text = "Fetching..."
            
        } else {
            // display an alert
            let alert = UIAlertController(title: "Error", message: "Please enter a valid location", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func getWeatherJson() {
        
        let urlAsString = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lon)&lon=\(lat)&units=imperial&appid=b6a54ede1934dcbfd07f2a127bcba765"
        print(urlAsString)
        let url = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
//            print(jsonResult)
            let weatherBoops:NSArray = jsonResult["list"] as! NSArray
            var weatherText:String = ""
            for boop in weatherBoops {
                let dayWeather:NSDictionary = boop as! NSDictionary
                let dt_txt = String(dayWeather["dt_txt"])
                if dt_txt.containsString(self.fmt_date) && weatherText == "" {
                    let dayWeather_weather:NSArray = dayWeather["weather"] as! NSArray
                    var descr = dayWeather_weather[0]["description"] as! String!
                    
                    weatherText += descr + "\n"
                    let temperatures:NSDictionary = dayWeather["main"] as! NSDictionary
                    weatherText += "Low: " + String(temperatures["temp_min"]!) + "\n"
                    weatherText += "High: " + String(temperatures["temp_max"]!) + "\n"
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.weatherDetailsLabel.text = String(weatherText)
                //                self.getDirections("China")
            })
        })
        
        jsonQuery.resume()
    }
    
    @IBAction func openMapsApp(sender: AnyObject) {
        print(mtg!.places!)
        var originalString = mtg!.places!
        var escapedString = originalString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/?q=\(escapedString!)")!)
    }
    
}