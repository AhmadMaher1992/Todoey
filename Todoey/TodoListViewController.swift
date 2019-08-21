//
//  ViewController.swift
//  Todoey
//
//  Created by Eisa on 1/24/19.
//  Copyright © 2019 Eisa. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
       
    }
    
    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator
        //Value = Condition ? Value If True : Value If False
        
        cell.accessoryType = item.done ? .checkmark : .none
       
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //MARK - Add New Items
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            let newItem = Item(context: self.context)
            guard let checkItem = textField.text , !checkItem.isEmpty else { return }
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
            
            //self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            //self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            //set up the alert text field
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        //show our alert
        
        present(alert , animated: true , completion: nil)
        
    }
    
    //MARK - Model Manupulation Methods
    
    func saveItems() {
        
        
        do {
          try  context.save()
        }catch{
            print("Error Saving Context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems(){
        
      
        
    }
    
    


}

