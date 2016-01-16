//
//  GostovanjeQRViewController.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 16. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit
import AVFoundation
import RSBarcodes_Swift

class GostovanjeQRViewController: UIViewController {
    @IBOutlet weak var qr: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        RSCode128Generator(codeTable: .A).generateCode("1234567890", machineReadableCodeObjectType:AVMetadataObjectTypeQRCode)
        
        let image = RSUnifiedCodeGenerator.shared.generateCode("1234567890", machineReadableCodeObjectType:AVMetadataObjectTypeQRCode)
        
        qr.image = RSAbstractCodeGenerator.resizeImage(image!, scale: 30)
        
        

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
