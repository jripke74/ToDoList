//
//  TodoListController.swift
//  TodoList
//
//  Created by Jeff Ripke on 8/22/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import UIKit
import CoreData

class TodoListController: UITableViewController {
    
    let managedObjectContext = CoreDataStack().managedObjectContext
    
    lazy var fetchedResultsController: TodoFetchedResultsController = {
        return TodoFetchedResultsController(managedObjectContext: self.managedObjectContext, tableView: self.tableView)
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        return configureCell(cell, at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = fetchedResultsController.object(at: indexPath)
        managedObjectContext.delete(item)
        managedObjectContext.saveChanges()
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        let item = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = item.text
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newItem" {
            let navigationController = segue.destination as! UINavigationController
            let addTaskController = navigationController.topViewController as! AddTaskController
            addTaskController.managedObjecContext = self.managedObjectContext
        } else if segue.identifier == "showDetail" {
            guard let detailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {
                    return
            }
            let item = fetchedResultsController.object(at: indexPath)
            detailVC.item = item
            detailVC.context = self.managedObjectContext
        }
    }
    
    
}
