//
//  OilChange.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/12/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import Foundation
import RealmSwift

class OilChange: Object {
    @objc dynamic var oilDate = ""
    @objc dynamic var auto = ""
    @objc dynamic var mileage = ""
    override static func primaryKey() -> String? {
        return "mileage"
    }

}
