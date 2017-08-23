//
//  AddTaskController.swift
//  TodoList
//
//  Created by Jeff Ripke on 8/22/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import UIKit
import CoreData

class AddTaskController: UIViewController {
    
    var managedObjecContext: NSManagedObjectContext!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func save(_ sender: Any) {
        
        guard let text = textField.text, !text.isEmpty else { return }
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedObjecContext) as! Item
        item.text = text
        
        managedObjecContext.saveChanges()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
