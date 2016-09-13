//
//  LoginVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 7/15/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: MaterialTextField!
    @IBOutlet weak var passwordField: MaterialTextField!

    let networkingService = NetworkingServices()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (FIRAuth.auth()?.currentUser) != nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListHome")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
                super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

	@IBAction func unwindToLogIn(storyboard: UIStoryboardSegue) {
		
	}
    
    @IBAction func signInBtnPressed(_ sender: AnyObject) {
        
       if let email = emailField.text , email != "", let password = passwordField.text , password != "" {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if user != nil {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListHome")
                    self.present(vc, animated: true, completion: nil)
                }

            } else if error!._code == 17011 {
                self.showErrorAlert(title: "Login Error", msg: "You do not have a valid Tasknerd account.   Please sign up")
                
            } else if error!._code == 17009 {
                self.showErrorAlert(title: "Login Error", msg: "Your passowrd is invalid")
            }
            
			
            
            self.emailField.text = ""
            self.passwordField.text = ""
        })
        
       } else {
        showErrorAlert(title: "Login Error", msg: "You must include both an email and password to login")
        }
    }

    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
  
}
