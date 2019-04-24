//
//  ViewController.swift
//  ToDoList
//
//  Created by marek on 23.04.2019.
//  Copyright © 2019 Marek Garczewski. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let user = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "Hello World"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Hi World"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Hey World"
        itemArray.append(newItem3)
        
        if let items = user.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items 
        }
    }
    
    // MARK:- tableView functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].done = !(itemArray[indexPath.row].done)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- add item button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item to list", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                self.user.set(self.itemArray, forKey: "ToDoListArray")
                self.tableView.reloadData()
        }
        
        alert.addTextField {
            (alertTextField) in
                alertTextField.placeholder = "Enter the text"
                textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

