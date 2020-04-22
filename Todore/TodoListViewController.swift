//
//  ViewController.swift
//  Todore
//
//  Created by Manjot S Sandhu on 16/4/20.
//  Copyright © 2020 Manjot S Sandhu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike","Buy eggs","Destry Demogorgon","Find stuff"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
}

