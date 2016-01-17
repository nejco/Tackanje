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

class GostovanjeQRViewController: RSCodeReaderViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //enkripcija
        let s = "Ime predmeta, dodatne informacije o predmetu, http://example.com"
        
        let enc = try! s.aesEncrypt(Static.key, iv: Static.iv)

        
        //generiraj QR kodo
        var image = RSUnifiedCodeGenerator.shared.generateCode(enc, machineReadableCodeObjectType:AVMetadataObjectTypeQRCode)
        
        image = RSAbstractCodeGenerator.resizeImage(image!, scale: 25)
        
        
        
        self.focusMarkLayer.strokeColor = UIColor.redColor().CGColor
        
        self.cornersLayer.strokeColor = UIColor.yellowColor().CGColor
        
        let c = CALayer()
        
        
        let label = UILabel()
        let sublayer = label.layer;
        
        // .. the rest of your layer initialization
        sublayer.backgroundColor = UIColor.whiteColor().CGColor
        sublayer.shadowOffset = CGSizeMake(0, 3);
        sublayer.shadowRadius = 5.0;
        sublayer.shadowColor = UIColor.blackColor().CGColor
        sublayer.shadowOpacity = 0.8;
        //        sublayer.cornerRadius = 12.0;
        sublayer.frame = CGRectMake(40, 80, 290 , 290);
        sublayer.borderColor = UIColor.blackColor().CGColor;
        sublayer.borderWidth = 0.5;
        // .. ended original source initialization
        
        image = Util.resizeImage(image!, newWidth: 580)
        
        
        sublayer.contents = image?.CGImage
        
        c.insertSublayer(sublayer, atIndex: 100)
        
        
        
        
        
        self.view.layer.addSublayer(c)
        
        self.barcodesHandler = { barcodes in
            for barcode in barcodes {
                print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
                
                let dec = try! barcode.stringValue.aesDecrypt(Static.key, iv: Static.iv)
                
                let podatki = dec.characters.split{$0 == ","}.map(String.init)
                
                let oseba = Oseba()
                
                oseba.ime = podatki[0]
                oseba.priimek = podatki[1]
                oseba.email = podatki[2]
                
                let seja = Seja() // TODO izberi sejo
                
                seja.seznamPrisotnih.append(oseba)

                
                self.alert(dec)
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.session.stopRunning()
                });
            }
        } // end barcodesHandler
        
        
        
        
        
    }
    
    func alert(besedilo:String) {
        let alertController = UIAlertController(title: "Alert", message:
            besedilo, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
            
            self.session.startRunning()
            
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
