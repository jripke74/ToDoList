//
//  Item+CoreDataProperties.swift
//  TodoList
//
//  Created by Jeff Ripke on 8/22/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        return request
    }

    @NSManaged public var text: String
    @NSManaged public var isCompleted: Bool

}
