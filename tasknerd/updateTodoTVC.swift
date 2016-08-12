//
//  updateTodoTVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 8/11/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class updateTodoTVC: UITableViewController {
    
    var todo: Todo!
    
    let networkingService = NetworkingServices()
    
    @IBOutlet weak var todoDetails: UITextView!
    @IBOutlet weak var todoName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoName.text = todo.todoName
        todoDetails.text = todo.todoDetails
        
        
        
    }
    @IBAction func saveTodo(_ sender: AnyObject) {
        
        if let name = todoName.text, name != "", let details = todoDetails.text, details != "" {
            var todoUpdates = Todo(todoName: name, todoDetails: details, username: (FIRAuth.auth()?.currentUser?.displayName)!)
            let key = self.todo.ref!.key
            let updateRef = networkingService.databaseRef.child("todos/\(key)")
            updateRef.updateChildValues(todoUpdates.toAnyObject())
            
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        
        
        
        
    }
    
    
    
}
