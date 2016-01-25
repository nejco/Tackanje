//
//  PorociloViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 25. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import MessageUI

class PorociloViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var isGostovan:Bool?
    var imePredmeta:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(isGostovan!) \(imePredmeta!)")
//        sendEmail()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            mail.setToRecipients(["\(defaults.stringForKey("email")!)"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
//            mail.addAttachmentData(attachment: NSData, mimeType: String, fileName: String)
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
            print("Napaka")
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
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
