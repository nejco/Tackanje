//
//  GostovanjeTableViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 15. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import CoreData


class GostovanjeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var seznamPredmetov:[String]?
    var predmeti = [NSManagedObject]()


    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh:",name:"load", object: nil)

        getPredmeti()


        tableView.delegate = self
        tableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }
    
    func refresh(notification: NSNotification){
        //load data here
        getPredmeti()
        self.tableView.reloadData()
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

        return seznamPredmetov!.count
    }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gostovanjeCell", forIndexPath: indexPath) as! GostovanjeTableViewCell

        cell.title.text = seznamPredmetov![indexPath.row]
        

        return cell
    }


    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
//            seznamPredmetov!.removeAtIndex(indexPath.row)
//            
//            predmeti.removeAtIndex(indexPath.row)
            
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext

            managedContext.deleteObject(predmeti[indexPath.row])

            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            getPredmeti()
            
            tableView.reloadData()
        }
    }
    
    func getPredmeti() {
        
        var seznam = Array<String>()
        
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

                seznam.append("\(predmet.valueForKey("imePredmeta")!)")
            }
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        seznamPredmetov = seznam
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "izberiSejo") {
            let svc = segue.destinationViewController as! GostujSejo2ViewController;
            
            svc.izbranPredmet = self.tableView.indexPathForCell(sender as! UITableViewCell)!.row
            
        }
    }
}
