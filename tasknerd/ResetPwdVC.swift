//
//  ResetPwdVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 7/15/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit


class ResetPwdVC: UIViewController {
    
    let networkingService = NetworkingServices()

    @IBOutlet weak var emailAddressField: MaterialTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resetPwdBtnPressed(_ sender: AnyObject) {
        if let email = emailAddressField.text, email != "" {
            
            networkingService.resetPwd(email: email)
            showErrorAlert(title: "Lost Password", msg: "An email with instructions on how to reset your password has been sent.")
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            self.present(vc, animated: true, completion: nil)

            
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
  
}
