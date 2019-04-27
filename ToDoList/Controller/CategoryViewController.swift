//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by marek on 24.04.2019.
//  Copyright © 2019 Marek Garczewski. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categoriesArray: Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoriesArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath )
        if let category = categoriesArray?[indexPath.row] {
            cell.textLabel?.text = category.name
            cell.backgroundColor = UIColor(hexString: category.color)
            
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
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
            newCategory.color = UIColor.randomFlat.hexValue()
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
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categoriesArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                    }
                } catch {
                    print("Error when deleting object \(error)")
                }
            }
    }
    
}
