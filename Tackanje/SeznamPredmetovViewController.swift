//
//  SeznamPredmetovViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 25. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import CoreData

class SeznamPredmetovViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var seznamGostovanihPredmetov = Array<String>()
    var seznamObiskanihPredmetov = Array<String>()
    
    var seznamGostovanihP = Array<Predmet>()
    var seznamObiskanihP = Array<Predmet>()
    
    var refreshControl:UIRefreshControl!
    
    
    
    
    func refresh(sender:AnyObject){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()

        })

    }


    @IBAction func logout(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        defaults.setValue(nil, forKey: "ime")
        defaults.setValue(nil, forKey: "priimek")
        defaults.setValue(nil, forKey: "email")
        performSegueWithIdentifier("logout", sender: self)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getObiskaniPredmeti()
        getGostovaniPredmeti()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return seznamObiskanihPredmetov.count
        } else {
            return seznamGostovanihPredmetov.count

        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("predmetCell", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(seznamObiskanihPredmetov[indexPath.row])"

        } else {
            cell.textLabel?.text = "\(seznamGostovanihPredmetov[indexPath.row])"

        }
        
        
        
        return cell
    }
 
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Obiskani predmeti"
        } else {
            return "Gostovani predmeti"
        }
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "porocanje") {
            let svc = segue.destinationViewController as! PorociloViewController
            
            let row = (self.tableView.indexPathForCell(sender as! UITableViewCell)?.row)!
            
            if (self.tableView.indexPathForCell(sender as! UITableViewCell)?.section)! == 0 {
                svc.isGostovan = false
                svc.imePredmeta = seznamObiskanihPredmetov[row]
//                svc.predmet = seznamObiskanihP[row]
            } else {
                svc.isGostovan = true
                svc.imePredmeta = seznamGostovanihPredmetov[row]
//                svc.predmet = seznamGostovanihP[row]

            }
    
        } 
    }
    
    func getObiskaniPredmeti() {
        var predmeti = [NSManagedObject]()
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "ObiskovaniPredmeti")
        
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            predmeti = results as! [NSManagedObject]
            
            for predmet in predmeti {
                seznamObiskanihPredmetov.append("\(predmet.valueForKey("imePredmeta")!)")
//                print("Predmet:\(predmet.valueForKey("imePredmeta")!)")
                let p = Predmet()
                p.imePredmeta = "\(predmet.valueForKey("imePredmeta")!)"
                p.dodatneInformacije = "\(predmet.valueForKey("dodatneInformacije")!)"
                p.povezava = "\(predmet.valueForKey("povezava")!)"
                seznamObiskanihP.append(p)

                
                
            }
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
 
    func getGostovaniPredmeti() {
        var predmeti = [NSManagedObject]()

        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "GostovaniPredmeti")
        
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            predmeti = results as! [NSManagedObject]
            
            for predmet in predmeti {
                seznamGostovanihPredmetov.append("\(predmet.valueForKey("imePredmeta")!)")
                let p = Predmet()
                p.imePredmeta = "\(predmet.valueForKey("imePredmeta")!)"
                p.dodatneInformacije = "\(predmet.valueForKey("dodatneInformacije")!)"
                p.povezava = "\(predmet.valueForKey("povezava")!)"
                seznamObiskanihP.append(p)
            }
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    
    
}
