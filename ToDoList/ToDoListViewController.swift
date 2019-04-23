//
//  ViewController.swift
//  ToDoList
//
//  Created by marek on 23.04.2019.
//  Copyright © 2019 Marek Garczewski. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["listen to music", "play basketball", "do an app in swift"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
}

