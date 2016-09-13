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
		self.todoComplete = (snapshot.value as? NSDictionary)?["todoComplete"] as? String
		self.todoName = (snapshot.value as? NSDictionary)?["todoName"] as! String
		self.todoDetails = (snapshot.value as? NSDictionary)?["todoDetails"] as! String
		self.username = (snapshot.value as? NSDictionary)?["username"] as! String
        self.key = snapshot.key
        self.ref = snapshot.ref
		
    }
    
    
    mutating func toAnyObject() -> [String: AnyObject] {
        var todoDict: [String: String]
        todoDict = ["todoName": todoName, "todoDetails": todoDetails,
                    "todoComplete": todoComplete, "username": username ]
        
        return todoDict as [String : AnyObject]
    }
}
