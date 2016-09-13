//
//  AddListTVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 9/13/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AddListTVC: UITableViewController {
	
	let networkingService = NetworkingServices()
	
	@IBOutlet weak var listDetails: UITextView!
	@IBOutlet weak var listName: UITextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	
	@IBAction func saveList(_ sender: AnyObject) {
		let listRef = self.networkingService.databaseRef.child("lists").childByAutoId()
		
		if let name = listName.text, name != "", let details = listDetails.text, details != "" {
			var list = List(listName: name, listDetails: details, listOwner: (FIRAuth.auth()?.currentUser?.displayName)!)
			listRef.setValue(list.toAnyObject())
			_ = self.navigationController?.popToRootViewController(animated: true)
		}
		
	}
	

}
