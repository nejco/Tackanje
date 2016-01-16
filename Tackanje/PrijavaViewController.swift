//
//  PrijavaViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 15. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import AVFoundation
import RSBarcodes_Swift

class PrijavaViewController: RSCodeReaderViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defauls = NSUserDefaults.standardUserDefaults()
        
        print(defauls.stringForKey("ime")!)
        print(defauls.stringForKey("priimek")!)
        print(defauls.stringForKey("email")!)
        
        
        //generiraj QR kodo
        var image = RSUnifiedCodeGenerator.shared.generateCode("1234567890", machineReadableCodeObjectType:AVMetadataObjectTypeQRCode)
        
        image = RSAbstractCodeGenerator.resizeImage(image!, scale: 20)
        
        
        
        

        self.focusMarkLayer.strokeColor = UIColor.redColor().CGColor
        
        self.cornersLayer.strokeColor = UIColor.yellowColor().CGColor
        
        let c = CALayer()
        

        let label = UILabel()
        label.text = "LOREN"
        let sublayer = label.layer;
        
        // .. the rest of your layer initialization
//        sublayer.backgroundColor = UIColor.whiteColor().CGColor
//        sublayer.shadowOffset = CGSizeMake(0, 3);
//        sublayer.shadowRadius = 5.0;
//        sublayer.shadowColor = UIColor.blackColor().CGColor
//        sublayer.shadowOpacity = 0.8;
//        sublayer.cornerRadius = 12.0;
        sublayer.frame = CGRectMake(0, 50, 200, 200);
//        sublayer.borderColor = UIColor.blackColor().CGColor;
//        sublayer.borderWidth = 0.5;
        // .. ended original source initialization
        
        sublayer.contents = image?.CGImage
        
        c.insertSublayer(sublayer, atIndex: 100)
        
        
        
        
        
        
        self.view.layer.addSublayer(c)
        
        self.barcodesHandler = { barcodes in
            for barcode in barcodes {
                print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.session.stopRunning()
                });
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
