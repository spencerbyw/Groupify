//
//  ListOfMeetingsVC.swift
//  Groupify
//
//  Created by Michael.Reichstein on 4/12/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import UIKit

class ListOfMeetingsVC: UIViewController {

    var selectedGroup: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedGroup!.name)
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
