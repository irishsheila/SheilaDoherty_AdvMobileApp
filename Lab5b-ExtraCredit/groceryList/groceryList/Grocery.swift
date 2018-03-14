//
//  Grocery.swift
//  groceryList
//
//  Created by Sheila Doherty on 3/6/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import Foundation
import RealmSwift

class Grocery: Object {
    @objc dynamic var name = ""
    @objc dynamic var bought = false
}
