//
//  Category.swift
//  Todoey
//
//  Created by Alex Liou on 9/8/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    @objc dynamic var color: String = "white"
}
