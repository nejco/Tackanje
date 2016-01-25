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
import AudioToolbox



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
        let s = "O,\(ime),\(priimek),\(email)"
        
        let enc = try! s.aesEncrypt(Static.key, iv: Static.iv)
        
        print(s) //string to encrypt
        print("enc:\(enc)") //2r0+KirTTegQfF4wI8rws0LuV8h82rHyyYz7xBpXIpM=
        
        
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
        
        2
        self.view.layer.addSublayer(c)
        
        self.barcodesHandler = { barcodes in
            var isScanned = false

            for barcode in barcodes {
                if isScanned == false {
                    isScanned = true
                    let dec = try! barcode.stringValue.aesDecrypt(Static.key, iv: Static.iv)
                    
                    let podatki = dec.characters.split{$0 == ","}.map(String.init)
                    
                    let predmet = Predmet()
                    
                    
                    
                    if podatki.count == 3 {
                        if podatki[0] == "S" {
                            let imePredmeta = podatki[1]
                            let tema = podatki[2]
  
                            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

//                            self.alert("Uspesna prijava na sejo",besedilo: "Ime predmeta:\(imePredmeta) \nTema:\(tema)")
//                            self.alert("Uspesna prijava na sejo",besedilo: "")

                            
                        }
                    } else
                    
                    if podatki.count == 4 {
                        if podatki[0] == "P" {
                            predmet.imePredmeta = podatki[1]
                            predmet.povezava = podatki[2]
                            predmet.dodatneInformacije = podatki[3]
                            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

                            self.alert("Uspesna prijava",besedilo: "Ime predmeta:\(predmet.imePredmeta!) \nDodatne informacije:\(predmet.dodatneInformacije!)\nPovezava:\(predmet.povezava!)")
                            
                        } else {
                            self.alert("Napaka!", besedilo: "Skeniral si napacno kodo!")
                        }
                        
                    } else {
                        self.alert("Napaka!", besedilo:"Skeniras lahko samo kodo aplikacije Tackanje!")
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.session.stopRunning()
                    isScanned = false
                });
            }
        }
    }
    
    func alert(naslov:String, besedilo:String) {
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: naslov, message:
                besedilo, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                
                self.session.startRunning()
                
            }))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        })
        
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
