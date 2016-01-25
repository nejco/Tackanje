//
//  DrugiViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 15. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import CoreData

class DrugiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        saveName("Testni podateeeeek1")
        saveGostovanPredmet("Nejc")
        saveGostovanPredmet("Eva")
        getSeje()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            for predmet in predmeti {
                print("Predmet:\(predmet.valueForKey("imePredmeta")!)")

                
                for seja in predmet.valueForKey("seja") as! NSSet {
                    print("Seje:\(seja.valueForKey("tema")!)")

                }
                
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    
    func getPredmeti() {
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
                print("Predmet:\(predmet.valueForKey("imePredmeta")!)")
                
                
                for seja in predmet.valueForKey("seja") as! NSSet {
                    print("Seje:\(seja.valueForKey("tema")!)")

                }

            }
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    

    
    func saveGostovanPredmet(name: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let obiskovaniPredmetiEntity =  NSEntityDescription.entityForName("GostovaniPredmeti",
            inManagedObjectContext:managedContext)
        
        let obiskovaneSejeEntity =  NSEntityDescription.entityForName("GostovaneSeje",
            inManagedObjectContext:managedContext)
        
        
        
        let obiskaniPredmeti = NSManagedObject(entity: obiskovaniPredmetiEntity!,
            insertIntoManagedObjectContext: managedContext)
        
        let obiskovaneSeje = NSManagedObject(entity: obiskovaneSejeEntity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        obiskaniPredmeti.setValue(name, forKey: "imePredmeta")
        obiskaniPredmeti.setValue(name, forKey: "povezava")
        obiskaniPredmeti.setValue(name, forKey: "dodatneInformacije")
        
        obiskovaneSeje.setValue("Sejaaaaaa", forKey: "tema")
        obiskovaneSeje.setValue(NSDate(), forKey: "datum")
        
        
        
        obiskaniPredmeti.setValue(NSSet(object: obiskovaneSeje), forKey: "seja")
        
        
        
        //4
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    
    
    
    func saveObiskovanPredmet(name: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let obiskovaniPredmetiEntity =  NSEntityDescription.entityForName("ObiskovaniPredmeti",
            inManagedObjectContext:managedContext)
        
        let obiskovaneSejeEntity =  NSEntityDescription.entityForName("ObiskovaneSeje",
            inManagedObjectContext:managedContext)
        
        
        
        let obiskaniPredmeti = NSManagedObject(entity: obiskovaniPredmetiEntity!,
            insertIntoManagedObjectContext: managedContext)
        
        let obiskovaneSeje = NSManagedObject(entity: obiskovaneSejeEntity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        obiskaniPredmeti.setValue(name, forKey: "imePredmeta")
        obiskaniPredmeti.setValue(name, forKey: "povezava")
        obiskaniPredmeti.setValue(name, forKey: "dodatneInformacije")
        
        obiskovaneSeje.setValue("Sejaaaaaa", forKey: "tema")
        obiskovaneSeje.setValue(NSDate(), forKey: "datum")

        
        
        obiskaniPredmeti.setValue(NSSet(object: obiskovaneSeje), forKey: "seje")

        
        
        //4
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}
