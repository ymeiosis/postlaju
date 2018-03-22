//
//  SignupViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 21/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignupViewController: UIViewController, UINavigationControllerDelegate {
    var ref: DatabaseReference!
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.layer.cornerRadius = 5.0
            imageView.layer.borderWidth = 5
            
            imageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(findImageButtonTapped))
            imageView.addGestureRecognizer(tap)
        }
    }

    @IBAction func editBtnTapped(_ sender: Any) {
        if let image = imageView.image {
            self.uploadToStorage(image)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        imagePicker.delegate = self
        // Tap on the side to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }

    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func findImageButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        signUpUser()
        print("can sign up user tap")
    }
    
    func signUpUser() {
        guard let email = emailTextField.text,
            let firstname = firstnameTextField.text,
            let lastname = lastnameTextField.text,
            let password = passwordTextField.text else {return}
        
        if !email.contains("@") {
            //show error //if email not contain @
            showAlert(withTitle: "Invalid Email format", message: "Please input valid Email")
        } else if password.count < 7 {
            //show error
            showAlert(withTitle: "Invalid Password", message: "Password must contain 6 characters")
        } else {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                //ERROR HANDLING
                if let validError = error {
                    self.showAlert(withTitle: "Error", message: validError.localizedDescription)
                }
                
                //HANDLE SUCESSFUL CREATION OF USER
                if let validUser = user {
                    self.emailTextField.text = ""
                    self.firstnameTextField.text = ""
                    self.lastnameTextField.text = ""
                    self.passwordTextField.text = ""
                     
                    
                    let userPost: [String:Any] = ["email": email, "firstname":firstname, "lastname":lastname]
                    
                    self.ref.child("users").child(validUser.uid).setValue(userPost)
                    
                    let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                    guard let navVC = sb.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {return}
                    
                    self.present(navVC, animated: true, completion: nil)
                    print("sign up method successful")
                }
            })
        }
    }
    
    func uploadToStorage(_ image: UIImage) {
        
        //Create Storage reference (location)
        let storageRef = Storage.storage().reference()
        
        //convert image to data
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return}
        
        // metadata contains details on the file type
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        storageRef.child(uid).child("profilepic").putData(imageData, metadata: metaData) { (meta, error) in
            
            //Error Handling
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            //Handle Successful case with metadata returned
            //MetaData contains details on the file uploaded on storage
            // We are checking whether a download URL exists
            if let downloadURL = meta?.downloadURL()?.absoluteString {
                
                self.ref.child("users").child(uid).child("profilepic").setValue(downloadURL)
                
            }
        }
    }

}
extension SignupViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
}
