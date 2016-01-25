//
//  DodajPredmetViewController.swift
//  
//
//  Created by Nejc Vidrih on 24. 01. 16.
//
//

import UIKit
import CoreData

class DodajPredmetViewController: UIViewController {
    @IBOutlet weak var nazivPredmeta: UITextField!
    @IBOutlet weak var opisPredmeta: UITextView!
    @IBOutlet weak var povezava: UITextField!
    
    @IBAction func shrani(sender: UIBarButtonItem) {
        dodajPredmet(nazivPredmeta.text!, opis: opisPredmeta.text!, povezava: povezava.text!)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dodajPredmet(naziv: String, opis:String, povezava:String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let ogostovaniPredmetiEntity =  NSEntityDescription.entityForName("GostovaniPredmeti",
            inManagedObjectContext:managedContext)
        
//        let obiskovaneSejeEntity =  NSEntityDescription.entityForName("ObiskovaneSeje",
//            inManagedObjectContext:managedContext)
        
        
        
        let gostovaniPredmeti = NSManagedObject(entity: ogostovaniPredmetiEntity!,
            insertIntoManagedObjectContext: managedContext)
        
//        let obiskovaneSeje = NSManagedObject(entity: obiskovaneSejeEntity!,
//            insertIntoManagedObjectContext: managedContext)
        
        //3
        gostovaniPredmeti.setValue(naziv, forKey: "imePredmeta")
        gostovaniPredmeti.setValue(povezava, forKey: "povezava")
        gostovaniPredmeti.setValue(opis, forKey: "dodatneInformacije")
        
//        obiskovaneSeje.setValue("Sejaaaaaa", forKey: "tema")
//        obiskovaneSeje.setValue(NSDate(), forKey: "datum")
//        
//        
//        
//        obiskaniPredmeti.setValue(NSSet(object: obiskovaneSeje), forKey: "seje")
        
        
        
        //4
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        print("Predmet \(naziv) je bil dodan")
        
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)

        performSegueWithIdentifier("gostuj", sender: self)
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
