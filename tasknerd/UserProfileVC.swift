//
//  UserProfileVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 7/30/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UserProfileVC: UIViewController {
    
    let networkingServices = NetworkingServices()
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var uidField: UITextField!
    
    override func viewDidLoad() {
        

        if let user = FIRAuth.auth()?.currentUser {
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid;
            
            usernameField.text = name
            emailField.text = email
            uidField.text = uid
            
            let imageUrl = String(describing: photoUrl!)
            networkingServices.storeageBaseRef.reference(forURL: imageUrl).data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
                if  let error = error {
                    print("user profile image error: \(error.localizedDescription)")
                } else {
                    if let data = data {
                        self.userImage.image = UIImage(data: data)
                    }
                }
            })
            
            
        } else {
            usernameField.text = "Not logged in"
            emailField.text = "Not available"
            uidField.text = "Not assigned"
            
        }
    }
    @IBAction func LogoutBtnPressed(_ sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                self.present(vc, animated: true, completion: nil)

            } catch let error as NSError {
                print("logout error: \(error.code)")
            }
        }
        
            }
}
