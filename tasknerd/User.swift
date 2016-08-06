//
//  User.swift
//  tasknerd
//
//  Created by Eric Torigian on 8/6/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    var username: String!
    var email: String!
    var photoUrl: String!
    var uid: String!
    var ref: FIRDatabaseReference
    var key: String
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        username = snapshot.value?["username"] as! String
        email = snapshot.value?["email"] as! String
        photoUrl = snapshot.value?["photoUrl"] as! String
        uid = snapshot.value?["uid"] as! String
        ref = snapshot.ref
        
        
    }
    
}
