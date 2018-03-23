//
//  AddViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 21/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import Pastel
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddViewController: UIViewController, UINavigationControllerDelegate {
    var ref: DatabaseReference!
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var addCaption: UITextField!
    
    @IBOutlet weak var addDate: UITextField!
    @IBAction func createBtn(_ sender: Any) {
        createIdea()
        print("can create idea")
    }
    @IBOutlet weak var addDescription: UITextView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet {
            
            imageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(findImageButtonTapped))
            imageView.addGestureRecognizer(tap)
        }
    }
    @IBAction func editBtnTapped(_ sender: Any) {
        if let image = imageView.image {
            self.uploadToStorage(image, ref.key)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        ref = Database.database().reference()
        imagePicker.delegate = self
        // Tap on the side to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        pastelview()
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func findImageButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
//    func createIdea() {
//        guard let caption = addCaption.text,
//            let location = locationTextField.text,
//            let posterID = Auth.auth().currentUser,
//            let timestamp = addDate.text else {return}
//
//        if caption.count == 0 {
//            showAlert(withTitle: "Invalid First Name", message: "Please input First Name")
//        } else if location.count == 0 {
//            showAlert(withTitle: "Invalid First Name", message: "Please input First Name")
//        } else if location.count == 0 {
//            //show error
//            showAlert(withTitle: "Invalid Password", message: "Password must contain 6 characters or more")
//        } else {
////            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
////                //ERROR HANDLING
////                if let validError = error {
////                    self.showAlert(withTitle: "Error", message: validError.localizedDescription)
////                }
////
//
//                //HANDLE SUCESSFUL CREATION OF USER
//                if let validUser = Auth.auth().currentUser {
//                    self.addCaption.text = ""
//                    self.addDescription.text = ""
//                    self.locationTextField.text = ""
//                    self.addDate.text = ""
//
//                    if let image = self.imageView.image {
//                        self.uploadToStorage(image)
//                    }
//
//                    let ideaPost: [String:Any] = ["email": email, "firstname":firstname, "lastname":lastname]
//
//                    self.ref.child("idea").child(validUser.uid).setValue(userPost)
//
//                    let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
//                    guard let navVC = sb.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {return}
//
//                    self.present(navVC, animated: true, completion: nil)
//                    print("sign up method successful")
//                }
//            })
//        }
//    }
    @objc func createIdea() {
        if let uid = Auth.auth().currentUser?.uid,
            let caption = addCaption.text,
            let date = addDate.text,
            let description = addDescription.text,
            let location = locationTextField.text,
            let image = imageView.image {
            
            let ideaRef = self.ref.child("ideas").childByAutoId()
            let status : Idea.status = .Unstarted
            
            uploadToStorage(image, ideaRef.key)
            
            let ideaPost : [String : Any] = ["title" : title, "date" : date, "description" : description, "location" : location, "status" : status.rawValue]
//            self.ref.child("ideas").child(imagePostUID).child("postedPicUrl").setValue(downloadURL)
            
            ideaRef.setValue(ideaPost)
            ref.child("users").child(uid).child("ideas").child(ideaRef.key).setValue(ideaPost)
            
            addCaption.text = ""
            addDate.text = ""
            addDescription.text = ""
            locationTextField.text = ""
            imageView.image = UIImage(named: "addCameraImage")
        }
    }
    
    func uploadToStorage(_ image: UIImage, _ imagePostUID: String) {
        
        //Create Storage reference (location)
        let storageRef = Storage.storage().reference()
        
        //convert image to data
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return}
        
        // metadata contains details on the file type
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        storageRef.child(uid).child(imagePostUID).putData(imageData, metadata: metaData) { (meta, error) in
            
            //Error Handling
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            //Handle Successful case with metadata returned
            //MetaData contains details on the file uploaded on storage
            // We are checking whether a download URL exists
            if let downloadURL = meta?.downloadURL()?.absoluteString {
                
                self.ref.child("ideas").child(imagePostUID).child("postedPicUrl").setValue(downloadURL)
                
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let navVC = sb.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {return}
                
                self.present(navVC, animated: true, completion: nil)
                print("create idea successful")
                
            }
        }
    }
    
}
extension AddViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
}
