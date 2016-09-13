//
//  ShowListsTVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 9/13/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ShowListsTVC: UITableViewController {
	var lists = [List]()
	var networkingServices = NetworkingServices()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let listRef = self.networkingServices.databaseRef.child("lists")
		
		listRef.observe(.value, with: {snapshot in
			self.lists = []
			
			for item in snapshot.children {
				let newList = List(snapshot: item as! FIRDataSnapshot)
				self.lists.insert(newList, at: 0)
				print("list: \(item)")
			}
			
			self.tableView.reloadData()
		})

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

	
    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return lists.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let list = self.lists[(indexPath).row]
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ListCell {
			cell.listNameLabel.text = list.listName
			cell.listOwnerLabel.text = list.listOwner
			cell.listDetailsLabel.text = list.listDetails
			return cell
		} else {
			return ListCell()
		}
		
	}

	
	
}
