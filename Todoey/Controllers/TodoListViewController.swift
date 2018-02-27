//
//  ViewController.swift
//  Todoey
//
//  Created by Clayton, David on 2/17/18.
//  Copyright © 2018 Clayton, David. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()

    }
    
    //MARK: Tableview datasource methods
    // Create the two datasource methods that specify 1. what the cells should display, and 2. how many rows we want in the tableview.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    
    //MARK: Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        saveItems()
        
        // Don't keep the row selected
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: Add new items
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to-do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // stuff that happens when user taps add
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Be more awesome."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK: Model manipulation methods
    
    func saveItems(){

        
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
        itemArray = try context.fetch(request)
        } catch {
            print("Error reading from context. \(error)")
        }
        tableView.reloadData()
    }
    

}

extension TodoListViewController : UISearchBarDelegate {
    
    //MARK: Search bar methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        print(searchBar.text!)
        
        // NSPredicate cheatsheet on Realm blog, and some help on nshipster.com/nspredicate. Adding "cd" makes it case and diacritic insensitive.
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }
}

