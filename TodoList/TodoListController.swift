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
    
    lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error fetching item objects: \(error.localizedDescription)")
        }
    }
    
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
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        let item = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = item.text
        return cell
    }
}
