//
//  ViewController.swift
//  Todoey
//
//  Created by Clayton, David on 2/17/18.
//  Copyright © 2018 Clayton, David. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Buy some milk","Wash clothes","Finish everything"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Tableview datasource methods
    // Create the two datasource methods that specify 1. what the cells should display, and 2. how many rows we want in the tableview.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    
    //MARK: Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Print the row number of index path inside item array.
        print(itemArray[indexPath.row])
        
        
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
        
    }
    
    //MARK: Add new items
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to-do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // stuff that happens when user taps add
            self.itemArray.append(textField.text! ?? "New item")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Be more awesome."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    

}

