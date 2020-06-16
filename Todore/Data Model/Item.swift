//
//  Item.swift
//  Todore
//
//  Created by Manjot S Sandhu on 14/6/20.
//  Copyright © 2020 Manjot S Sandhu. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    // inverse relationship to cateogory
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
