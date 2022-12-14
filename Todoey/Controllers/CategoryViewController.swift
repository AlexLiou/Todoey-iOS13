//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Alex Liou on 9/7/22.
//  Copyright © 2022 App Brewery. All rights reserved.
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

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)

        var textField = UITextField()
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }

        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            // What will happen once the user clicks the Add Item button.

            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)

            self.saveCategories()
        }

        alert.addAction(action)

        present(alert, animated: true)
    }

    //MARK: - Data Manipulation Methods
    func saveCategories() {

        do {
            try context.save()
        } catch {
            print("Error encoding category array, \(error)")
        }
        self.tableView.reloadData()
    }

    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {

        do {
            categoryArray = try context.fetch(request)

        } catch {
            print("Error fetching data from context \(error)")
        }

        tableView.reloadData()
    }
}

//MARK: - TableView Delegate Methods
extension CategoryViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
}

//MARK: - TableView DataSource Methods
extension CategoryViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        let category = categoryArray[indexPath.row]

        cell.textLabel?.text = category.name

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    
}
