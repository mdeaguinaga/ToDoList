//
//  ToDoListViewController.swift
//  Notes
//
//  Created by Manuel De Aguinaga on 12/21/18.
//  Copyright © 2018 Manuel De Aguinaga. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var itemArray = ["Thing 1","Thing 2","Thing 3"]
    let defaults = UserDefaults.standard
    
    /************************************************
     //viewDidLoad
    *************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }
    
    /************************************************
     //Tableview Datasourse Methods
     *************************************************/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    /************************************************
    //tableView
    *************************************************/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    /************************************************
     // Table Delegate methods
    *************************************************/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /************************************************
     //  tableView
     Deletes the item in the list and updates the
     itemArray
     *************************************************/
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.itemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(self.itemArray)
            self.defaults.set(self .itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        /*
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            // share item at indexPath
            print("I want to share: \(self.itemArray[indexPath.row])")
        }
        share.backgroundColor = UIColor.lightGray
        return [delete, share]
        */
        return [delete]
    }
    
    
    
    /************************************************
     // Add new item
     1- Manage the add buttom (+) at the top ot the
     app and display the add item window
     2- Once the item is added, updates the ithemArray
     and save it on the back (database)
    *************************************************/
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()   // Variable for the text input
        //Creates a controller object
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        //Accion
        let accion = UIAlertAction(title: "Add Item", style: .default) { (accion) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self .itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        //Prints a message and takes an input
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "Create New Item"
            textField = AlertTextField
        }
        alert.addAction(accion)
        present(alert, animated: true, completion: nil)
    }
}

