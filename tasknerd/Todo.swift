//
//  Todo.swift
//  tasknerd
//
//  Created by Eric Torigian on 8/6/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Todo {
    var todoName: String!
    var todoDetails: String!
    var todoComplete: String!
    var username: String!
    var ref: FIRDatabaseReference?
    var key: String!

    
    init(todoName: String, todoDetails: String, username: String) {
        self.todoComplete = "false"
        self.todoName = todoName
        self.todoDetails = todoDetails
        self.username = username
        self.key = ""
        self.ref = FIRDatabase.database().reference()
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.todoComplete = snapshot.value!["todoComplete"] as! String
        self.todoName = snapshot.value!["todoName"] as! String
        self.todoDetails = snapshot.value!["todoDetails"] as! String
        self.username = snapshot.value!["username"] as! String
        self.key = snapshot.key
        self.ref = snapshot.ref
        
    }
    
    
    mutating func toAnyObject() -> [String: AnyObject] {
        var todoDict: [String: AnyObject]
        todoDict = ["todoName": todoName, "todoDetails": todoDetails,
                    "todoComplete": todoComplete, "username": username ]
        
        return todoDict
    }
}
