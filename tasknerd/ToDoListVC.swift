//
//  ToDoListVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 7/15/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ToDoListVC: UITableViewController {
    
    var todos = [Todo]()
    var networkingService = NetworkingServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todoRef = self.networkingService.databaseRef.child("todos")
        
        todoRef.observe(.value, with: { snapshot in
            self.todos = []
            
            for item in snapshot.children {
                let newTodo = Todo(snapshot: item as! FIRDataSnapshot)
                self.todos.insert(newTodo, at: 0)

                print("item: \(item)")
            }
            
            self.tableView.reloadData()
            
            }) { (error) in
                print("todo retrive error:  \(error.code)")
        }
    }
    
    //MARK: Tableview functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count;
    }
        
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let todo = self.todos[(indexPath as NSIndexPath).row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as? TodoCell {
            cell.todoNameField.text = todo.todoName
            cell.todoDetailField.text = todo.todoDetails
            cell.usernameField.text = todo.username
            return cell
        } else {
            return TodoCell()
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ref = todos[indexPath.row].ref
            ref?.removeValue()
            todos.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateTodo", sender: self )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "updateTodo" {
            
            let vc = segue.destinationViewController as! updateTodoTVC
            let indexPath = tableView.indexPathForSelectedRow!
            
            vc.todo = todos[indexPath.row]
        }
    }
}
