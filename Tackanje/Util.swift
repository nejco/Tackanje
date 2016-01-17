//
//  Util.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 17. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import UIKit

class Util {
    
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
}