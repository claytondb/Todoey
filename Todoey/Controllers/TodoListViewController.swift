//
//  ViewController.swift
//  Todoey
//
//  Created by Clayton, David on 2/17/18.
//  Copyright © 2018 Clayton, David. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
// The way you're saving data is by encoding the array of data into a plist (property list) and then decoding it back into the array when the app is loaded.
    
    var itemArray = [Item]()
    
//    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
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
        
        // Print the row number of index path inside item array.
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            // Remove checkmark if there is one
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            // Add checkmark accessory to the row when it's selected
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // Don't keep the row selected
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.saveItems()
        
    }
    
    //MARK: Add new items
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to-do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // stuff that happens when user taps add
            
            let newItem = Item()
            newItem.title = textField.text!
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
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array. \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array. \(error)")
            }
        }
    }
    

}

