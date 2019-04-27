//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by marek on 24.04.2019.
//  Copyright © 2019 Marek Garczewski. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var categoriesArray: Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoriesArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoriesArray?[indexPath.row].name ?? "No categories added yet"
        return cell
    } 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoriesArray?[indexPath.row]
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category to list", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.saveCategories(category: newCategory)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategories (category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error with saving category: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categoriesArray = realm.objects(Category.self )
        tableView.reloadData()
    }
    
}
