//
//  PrijavaViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 15. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import RSBarcodes_Swift

class PrijavaViewController: RSCodeReaderViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defauls = NSUserDefaults.standardUserDefaults()
        
        print(defauls.stringForKey("ime")!)
        print(defauls.stringForKey("priimek")!)
        print(defauls.stringForKey("email")!)

        self.focusMarkLayer.strokeColor = UIColor.redColor().CGColor
        
        self.cornersLayer.strokeColor = UIColor.yellowColor().CGColor

        
        self.barcodesHandler = { barcodes in
            for barcode in barcodes {
                print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
            }
        }

    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
