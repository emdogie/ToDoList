//
//  ViewController.swift
//  ToDoList
//
//  Created by marek on 23.04.2019.
//  Copyright © 2019 Marek Garczewski. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["0:25", "0:30", "0:35"]
    let user = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = user.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }
    
    // MARK:- tableView functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- add item button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item to list", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) {
            (alert) in
                self.itemArray.append(textField.text!)
                self.tableView.reloadData()
                self.user.set(self.itemArray, forKey: "ToDoListArray")
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

