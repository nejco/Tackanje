//
//  ViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 14. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import OAuthSwift
import CloudKit


class LoginViewController: UIViewController {
    @IBOutlet weak var ime: UITextField!
    @IBOutlet weak var priimek: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func login(sender: UIButton) {
       let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(ime.text, forKey: "ime")
        defaults.setValue(priimek.text, forKey: "priimek")
        defaults.setValue(email.text, forKey: "email")
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.performSegueWithIdentifier("login", sender: self)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

