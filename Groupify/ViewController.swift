//
//  ViewController.swift
//  Groupify
//
//  Created by Spencer.Bywater on 3/24/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var restText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        communicateWithGoogle()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func communicateWithGoogle() {
        
    }

}

