//
//  Predmet.swift
//  Tackanje
//
//  Created by Nejc Vidrih on 17. 01. 16.
//  Copyright © 2016 Nejc Vidrih. All rights reserved.
//

import Foundation

class Predmet {
    var imePredmeta:String?
    
    var dodatneInformacije:String?
    
    var povezava:String?
    
    var seznamSej:[Seja]
    
    var seznamObiskovalcev:[Oseba]
    
    init() {
        seznamObiskovalcev = [Oseba()]
        seznamSej = [Seja()]
    }

}
