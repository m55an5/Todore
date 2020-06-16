//
//  Category.swift
//  Todore
//
//  Created by Manjot S Sandhu on 14/6/20.
//  Copyright © 2020 Manjot S Sandhu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    
    // to-many relationship
    let items = List<Item>()
}
