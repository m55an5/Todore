//
//  CategoryViewController.swift
//  Todore
//
//  Created by Manjot S Sandhu on 29/4/20.
//  Copyright © 2020 Manjot S Sandhu. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    // make categories optional
    // Results is an auto updating list
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    //MARK: - TABLE VIEW Datasouce Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if categories is not nill then return categories.count else return 1
        // nil coalescing operator
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let category = categories?[indexPath.row].name ?? "No Categories added yet"
        
        cell.textLabel?.text = category
        
        return cell
        
    }
    
    //MARK: - TABLE VIEW Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            print("PREPARE FOR SEGUE")
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving category, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - Delete data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
       //  handle action by updating model with deletion
        if let category = self.categories?[indexPath.row]{
            do {
                try self.realm.write { // updates the database
                    self.realm.delete(category) // updates with this change i.e. delete in this case
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
                    
    }
    
    //MARK: - ADD New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var newCategoryEntered = UITextField()

        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) {
            (action) in
            
            let newCategory = Category()
            newCategory.name = newCategoryEntered.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Create new category"
            newCategoryEntered = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
