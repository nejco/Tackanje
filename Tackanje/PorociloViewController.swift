//
//  PorociloViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 25. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import MessageUI
import CoreData

class PorociloViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    var isGostovan:Bool?
    var imePredmeta:String?
//    var predmet:Predmet?
    
    @IBOutlet weak var imePredmetaLabel: UILabel!
    var seje = Array<String>()
    
    var csv = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("\(isGostovan!) \(imePredmeta!)")
        
        imePredmetaLabel.text = "\(imePredmeta!)"

//        imePredmetaLabel.text = "\(imePredmeta!)\n\(predmet?.povezava!)\n\(predmet?.dodatneInformacije!)\n"
        
        if (isGostovan! == false) {
            getObiskaneSeje(imePredmeta!)
        } else {
            getGostovaneSeje(imePredmeta!)
        }
        
        for seja in seje {
            textView.text! += "\(seja)\n"
        }
//        sendEmail()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exportCSV(sender: AnyObject) {
        let data = (csv as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        sendEmail(data!)
    }
    
    func sendEmail(priponka:NSData) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            mail.setToRecipients(["\(defaults.stringForKey("email")!)"])
            mail.setMessageBody("<p>V priponki!<br><br>Lep pozdrav, Tackanje</p>", isHTML: true)
            mail.setSubject("Export predmeta \(imePredmeta!)")
            mail.addAttachmentData(priponka, mimeType: "text/csv", fileName: "\(imePredmeta!).csv")
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
            print("Napaka")
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getObiskaneSeje(imePredmeta:String) {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let pred = NSPredicate(format: "(imePredmeta = %@)", "\(imePredmeta)")
        
        let fetchRequest = NSFetchRequest(entityName: "ObiskovaniPredmeti")
        fetchRequest.predicate = pred

        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let match = results[0] as! NSManagedObject
            
            for seja in match.valueForKey("seje") as! NSSet {
                let datum = seja.valueForKey("datum") as! NSDate
                
                let formatter = NSDateFormatter()
                formatter.dateStyle = NSDateFormatterStyle.LongStyle
                formatter.timeStyle = .MediumStyle
                
                let dateString = formatter.stringFromDate(datum)
                
                csv += "\(dateString);\(seja.valueForKey("tema")!)\n"
                
                seje.append("\(dateString): \(seja.valueForKey("tema")!)")
                //                print("Seje:\(seja.valueForKey("tema")!)")

            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func getGostovaneSeje(imePredmeta:String) {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let pred = NSPredicate(format: "(imePredmeta = %@)", "\(imePredmeta)")
        
        let fetchRequest = NSFetchRequest(entityName: "GostovaniPredmeti")
        fetchRequest.predicate = pred
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let match = results[0] as! NSManagedObject
            
            for seja in match.valueForKey("seja") as! NSSet {
                let datum = seja.valueForKey("datum") as! NSDate
                
                let formatter = NSDateFormatter()
                formatter.dateStyle = NSDateFormatterStyle.LongStyle
                formatter.timeStyle = .MediumStyle
                
                let dateString = formatter.stringFromDate(datum)
                
                csv += "\(dateString);\(seja.valueForKey("tema")!)\n"

                seje.append("\(dateString): \(seja.valueForKey("tema")!)")
                //                print("Seje:\(seja.valueForKey("tema")!)")
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
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
