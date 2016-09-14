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
			cell.listDetailsLabel.text = list.listDetails
			return cell
		} else {
			return ListCell()
		}
		
	}
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ref = lists[indexPath.row].ref
            ref?.removeValue()
            lists.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showListItems", sender: self )
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListItems" {
            let vc = segue.destination as! showListItemsTVC
            let indexPath = tableView.indexPathForSelectedRow!
            
            vc.list = lists[indexPath.row]
        }
    }


	
	
}
