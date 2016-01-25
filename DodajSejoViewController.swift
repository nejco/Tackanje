//
//  DodajSejoViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 25. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import CoreData

class DodajSejoViewController: UIViewController {
    
    @IBOutlet weak var tema: UITextField!
    var izbranPredmet:Int?
    var imePredmeta:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        dodajSejo(izbranPredmet!, tema: tema.text!)
        
        performSegueWithIdentifier("gostujSeje", sender: self)
    }
    
    func dodajSejo(predmetID:Int, tema:String) {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let pred = NSPredicate(format: "(imePredmeta = %@)", "\(imePredmeta!)")
        let fetchRequest = NSFetchRequest(entityName: "GostovaniPredmeti")
        fetchRequest.predicate = pred
        
        
        let gostovaneSejeEntity =  NSEntityDescription.entityForName("GostovaneSeje",
            inManagedObjectContext:managedContext)

        
        let gostovaneSeje = NSManagedObject(entity: gostovaneSejeEntity!,
            insertIntoManagedObjectContext: managedContext)
        
        gostovaneSeje.setValue("\(tema)", forKey: "tema")
        gostovaneSeje.setValue(NSDate(), forKey: "datum")

        
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let match = results[0] as! NSManagedObject
            
            
            
            match.addObject(gostovaneSeje, forKey: "seja")
            
            print("iskan:\(imePredmeta!), ID:\(izbranPredmet!), results:\(match.valueForKey("seja"))")
            
            try managedContext.save()


            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
        
        
//        
//        let obiskovaneSejeEntity =  NSEntityDescription.entityForName("GostovaneSeje",
//            inManagedObjectContext:managedContext)
//        
//        let obiskovaneSeje = NSManagedObject(entity: obiskovaneSejeEntity!,
//        insertIntoManagedObjectContext: managedContext)
//    
//        obiskovaneSeje.setValue("\(tema)", forKey: "tema")
//        obiskovaneSeje.setValue(NSDate(), forKey: "datum")
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "gostujSeje") {
            let svc = segue.destinationViewController as! GostujSejo2ViewController;
            
            svc.izbranPredmet = izbranPredmet
            
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
