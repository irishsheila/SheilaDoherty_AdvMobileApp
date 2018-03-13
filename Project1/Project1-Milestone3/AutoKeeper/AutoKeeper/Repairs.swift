//
//  Repairs.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/11/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import Foundation
import RealmSwift

class Repairs: Object {
    @objc dynamic var car = ""
    @objc dynamic var date = ""
    @objc dynamic var repair = ""
    @objc dynamic var notes = ""
    override static func primaryKey() -> String? {
        return "date"
    }
}

