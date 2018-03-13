//
//  AutoInfo.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/8/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//


import Foundation
import RealmSwift

class AutoInfo: Object {
    @objc dynamic var year = ""
    @objc dynamic var make = ""
    @objc dynamic var model = ""
    @objc dynamic var vin = ""
    @objc dynamic var license = ""
    @objc dynamic var insuranceco = ""
    @objc dynamic var insurancepolicynum = ""
    @objc dynamic var insurancephone = ""
    
    override static func primaryKey() -> String? {
        return "license"
    }
 
}

