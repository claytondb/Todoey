//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Clayton, David on 3/2/18.
//  Copyright © 2018 Clayton, David. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK: Tableview datasource methods
    // Create the two datasource methods that specify 1. what the cells should display, and 2. how many rows we want in the tableview.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //MARK: Data manipulation methods
    func saveCategories(){
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error reading from context. \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // stuff that happens when user taps add
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategories()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Be more awesome."
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: Tableview delegate methods - what should happen when we click on one of the items in the tableview
    
    
}
