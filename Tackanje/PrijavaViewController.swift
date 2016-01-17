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
import CryptoSwift


class PrijavaViewController: RSCodeReaderViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defauls = NSUserDefaults.standardUserDefaults()
        
        print(defauls.stringForKey("ime")!)
        print(defauls.stringForKey("priimek")!)
        print(defauls.stringForKey("email")!)
        
        let ime = defauls.stringForKey("ime")!
        let priimek = defauls.stringForKey("priimek")!
        let email = defauls.stringForKey("email")!
        
//        alert("\(ime),\(priimek),\(email)")
        let s = "\(ime),\(priimek),\(email)"
        
        let enc = try! s.aesEncrypt(Static.key, iv: Static.iv)
        
        print(s) //string to encrypt
        print("enc:\(enc)") //2r0+KirTTegQfF4wI8rws0LuV8h82rHyyYz7xBpXIpM=
        
        
//        let input: [UInt8] = [0,1,2,3,4,5,6,7,8,9]
//        input.encrypt(AES(key: "secret0key000000", iv:"0123456789012345", blockMode: .CBC))
        
        //generiraj QR kodo
        var image = RSUnifiedCodeGenerator.shared.generateCode("\(enc)", machineReadableCodeObjectType:AVMetadataObjectTypeQRCode)
        
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
        sublayer.frame = CGRectMake(40, 20, 290 , 290);
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
                
                let predmet = Predmet()
                
                predmet.imePredmeta = podatki[0]
                predmet.dodatneInformacije = podatki[1]
                predmet.povezava = podatki[2]
                
                
                self.alert("Ime predmeta:\(predmet.imePredmeta!) \nDodatne informacije:\(predmet.dodatneInformacije!)\nPovezava:\(predmet.povezava!)"
)

                dispatch_async(dispatch_get_main_queue(), {
                    self.session.stopRunning()
                });
            }
        }
        
        

    
    
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
