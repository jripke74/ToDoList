//
//  CoreDataStack.swift
//  TodoList
//
//  Created by Jeff Ripke on 8/22/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private(set) lazy var applicationDocumentDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let endIndex = urls.index(before: urls.endIndex)
        return urls[endIndex]
    }()
    
    private(set) lazy var managedObjectModel: NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: "ToDoList", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
}
