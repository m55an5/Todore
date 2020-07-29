//
//  ViewController.swift
//  Todore
//
//  Created by Manjot S Sandhu on 16/4/20.
//  Copyright © 2020 Manjot S Sandhu. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var todoItems: Results<Item>?
    
    var selectedCategory : Category? {
        // as soon as selectedCatergory is set with some value didSet will trigger
        didSet{
            print("CATEGROY DIDSET")
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)
    }


    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
                
            cell.textLabel?.text = item.title
                
            cell.accessoryType = item.done ? .checkmark : .none
                
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        return cell
        
    }
    
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                item.done = !item.done
                }
            } catch {
                print("Error updating done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
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
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = newItemEntered.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
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
    
    //MARK: - delete item in row
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = todoItems?[indexPath.row]{
                do {
                    try realm.write { // updates the database
                        realm.delete(item) // updates with this change i.e. delete in this case
                    }
                } catch {
                    print("Error deleting item, \(error)")
                }
            }
        }
        tableView.reloadData()
    }*/
    
    //MARK: - Delete data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
       //  handle action by updating model with deletion
        if let item = self.todoItems?[indexPath.row]{
            do {
                try self.realm.write { // updates the database
                    self.realm.delete(item) // updates with this change i.e. delete in this case
                }
            } catch {
                print("Error deleting items, \(error)")
            }
        }
                    
    }
    
    func save(item: Item) {

        do {
            try realm.write {
                realm.add(item)
            }
        }catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}

