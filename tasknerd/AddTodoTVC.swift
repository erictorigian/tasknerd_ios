//
//  AddTodoTVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 7/15/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AddTodoTVC: UITableViewController {

    let networkingService = NetworkingServices()
    
    @IBOutlet weak var todoDetails: UITextView!
    @IBOutlet weak var todoName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    @IBAction func saveTodo(_ sender: AnyObject) {
        let todoRef = self.networkingService.databaseRef.child("todos").childByAutoId()
        
        if let name = todoName.text, name != "", let details = todoDetails.text, details != "" {
            var todo = Todo(todoName: name, todoDetails: details, username: (FIRAuth.auth()?.currentUser?.displayName)!)
            todoRef.setValue(todo.toAnyObject())
        }
        
        
        

    }

   }
