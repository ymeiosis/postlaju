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

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Tap on the side to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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

}
