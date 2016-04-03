//
//  MemberInfoVC.swift
//  Groupify
//
//  Created by Spencer.Bywater on 4/2/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import Foundation
import UIKit

class MemberInfoVC: UIViewController {
    var selectedMember: Member?
    var addSegue: Bool = false
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}