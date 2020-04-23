//
//  ViewController.swift
//  Todore
//
//  Created by Manjot S Sandhu on 16/4/20.
//  Copyright © 2020 Manjot S Sandhu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy eggs","Destry Demogorgon","Find stuff"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if condtition makes sure defaults array exists
        if let items = defaults.array(forKey: "toDoListArray") as? [String] {
            itemArray  = items
        }
        
    }

    
    
    
    //MARK: - TableView DataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // code below will add and remove checkmark dependign on if row has it or not
        let tableAccessoryContent = tableView.cellForRow(at: indexPath)
        
        if tableAccessoryContent?.accessoryType == .checkmark {
            tableAccessoryContent?.accessoryType = .none
        }else{
            tableAccessoryContent?.accessoryType = .checkmark
        }
        
        // to stop the backgroung grey color on cell that we select
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: - ADD NEW ITEMS SECTION
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newItemEntered = UITextField()
        
        let alert = UIAlertController(title: "Add New Todore Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            //what will happend once the user clicks the add item button on our UI ALERT
            // TODO: check if entry is not empty
            self.itemArray.append(newItemEntered.text!)
            
            self.defaults.set(self.itemArray, forKey: "toDoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField {
            (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newItemEntered = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemArray.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    
}

