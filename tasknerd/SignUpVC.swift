//
//  SignUpVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 7/15/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class SignUpVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	let networkingService = NetworkingServices()
    
    @IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var passwordConfirmField: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func userImageTap(_ sender: AnyObject) {
		
		let pickerController = UIImagePickerController()
		pickerController.delegate = self
		pickerController.allowsEditing = true
		
		let alertController = UIAlertController(title: "Choose a Picture", message: "Choose your source for your picture", preferredStyle: .actionSheet)
		
		let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
			
			pickerController.sourceType = .camera
            pickerController.cameraCaptureMode = .photo
			self.present(pickerController, animated: true, completion: nil)
			
		}
		
		let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (UIAlertAction) in
			
			pickerController.sourceType = .photoLibrary
			self.present(pickerController, animated: true, completion: nil)
			
		}
		
		let savedPhotosAlbumAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (UIAlertAction) in
			
			pickerController.sourceType = .savedPhotosAlbum
			self.present(pickerController, animated: true, completion: nil)
			
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
		
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }

		alertController.addAction(photoLibraryAction)
		alertController.addAction(savedPhotosAlbumAction)
		alertController.addAction(cancelAction)
		
		present(alertController, animated: true, completion: nil)
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		self.dismiss(animated: true, completion: nil)
		self.userImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
	}
	
	
	@IBAction func signUpBtnPressed(_ sender: AnyObject) {
        let data = UIImageJPEGRepresentation(userImageView.image!, 0.8)
        networkingService.createUser(email: emailField.text!, username: usernameField.text!, password: passwordField.text!, data: data)
	}
}
