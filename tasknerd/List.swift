//
//  List.swift
//  tasknerd
//
//  Created by Eric Torigian on 9/13/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct List {
	var listName: String!
	var listDetails: String!
	var listOwner: String!
	var ref: FIRDatabaseReference?
	var key: String!
	
	init (listName: String, listDetails: String, listOwner: String) {
		self.listName = listName
		self.listDetails = listDetails
		self.listOwner = listOwner
		self.key = ""
		self.ref = FIRDatabase.database().reference()
	}
	
	init (snapshot: FIRDataSnapshot) {
		self.listName = (snapshot.value as? NSDictionary)?["listName"] as! String!
		self.listDetails = (snapshot.value as? NSDictionary)?["listDetails"] as! String!
		self.listOwner = (snapshot.value as? NSDictionary)?["listOwner"] as! String!
		self.key = snapshot.key
		self.ref = snapshot.ref
	}
	
	mutating func toAnyObject() -> [String: AnyObject] {
		var listDict: [String: String]
		listDict = ["listName": listName, "listDetails": listDetails,
					"listOwner": listOwner]
		
		return listDict as [String: AnyObject]
	}
	
}
