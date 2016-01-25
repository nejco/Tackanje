//
//  GostovanjeTableViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 15. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import CoreData


class GostujSejo2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var seznamSej = Array<String>()
    var izbranPredmet:Int?
    var predmeti = [NSManagedObject]()
    var izbranPredmetString:String?
    var povezava:String?
    var dodatneInformacije:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSeje()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return seznamSej.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("seje", forIndexPath: indexPath)
        
        cell.textLabel?.text = seznamSej[indexPath.row]
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            //            seznamSej!.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    func getSeje() {
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
            
            var i = 0
            
            for predmet in predmeti {
                //                print("Predmet:\(predmet.valueForKey("imePredmeta")!)")
                
                if i == izbranPredmet! {
                    izbranPredmetString = "\(predmet.valueForKey("imePredmeta")!)"
                    povezava = "\(predmet.valueForKey("povezava")!)"
                    dodatneInformacije = "\(predmet.valueForKey("dodatneInformacije")!)"

                    for seja in predmet.valueForKey("seja") as! NSSet {
                        //                        print("Seje:\(seja.valueForKey("tema")!)")
                        seznamSej.append("\(seja.valueForKey("tema")!)")
                        
                    }
                }
                
                i++
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "dodajSejo") {
            let svc = segue.destinationViewController as! DodajSejoViewController;
            
            svc.izbranPredmet = izbranPredmet
            
            svc.imePredmeta = izbranPredmetString
            
        } else if segue.identifier == "qr" {
            let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! GostovanjeQRViewController
            
            targetController.tema = seznamSej[(self.tableView.indexPathForCell(sender as! UITableViewCell)?.row)!]
            
            let predmet = Predmet()
            predmet.imePredmeta = izbranPredmetString!
            predmet.povezava = povezava!
            predmet.dodatneInformacije = dodatneInformacije!
            
            targetController.predmet = predmet
        }
    }
}
