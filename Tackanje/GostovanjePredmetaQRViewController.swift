//
//  GostovanjePredmetaQRViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 25. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import AVFoundation
import RSBarcodes_Swift


class GostovanjePredmetaQRViewController: UIViewController {

    @IBOutlet weak var qr: UIImageView!
    
    var predmet:Predmet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s = "P,\(predmet!.imePredmeta!),\(predmet!.povezava!),\(predmet!.dodatneInformacije!)"
        
        print(s)
        
        let enc = try! s.aesEncrypt(Static.key, iv: Static.iv)
        
        
        //generiraj QR kodo
        var image = RSUnifiedCodeGenerator.shared.generateCode(enc, machineReadableCodeObjectType:AVMetadataObjectTypeQRCode)
        
        image = RSAbstractCodeGenerator.resizeImage(image!, scale: 25)
        
        qr.image = image
        // Do any additional setup after loading the view.
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
