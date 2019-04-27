//
//  Category.swift
//  ToDoList
//
//  Created by marek on 27.04.2019.
//  Copyright © 2019 Marek Garczewski. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>() 
}
