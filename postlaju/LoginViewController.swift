//
//  LoginViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 21/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        }
    }
     var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        userChecking()
        
        //Set Background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "EducationBackground")
        self.view.insertSubview(backgroundImage, at: 0)
        
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
    func userChecking () {
        ref.child("users").observe(.childAdded) { (snapshot) in
            guard let currentUserUID = Auth.auth().currentUser?.uid else {return}
            
            if Auth.auth().currentUser != nil && currentUserUID == snapshot.key {
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let navVC = sb.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {return}
                
                self.present(navVC, animated: true, completion: nil)
            }
        }
    }
    
    @objc func signInButtonTapped() {
        var userisRegistered : Bool = false
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {return}
        
        ref.child("users").observe(.value) { (snapshot) in
            
            if let dict = snapshot.value as? [String:Any] {
                
                for id in dict {
                    if let idValues = id.value as? [String:Any],
                        let emailValue = idValues["email"] as? String {
                        
                        if email == emailValue {
                            userisRegistered = true
                            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                                if let validError = error {
                                    self.showAlert(withTitle: "Error", message: validError.localizedDescription)
                                    
                                }
                                
                                if user != nil {
                                    self.emailTextField.text = ""
                                    self.passwordTextField.text = ""
                                    let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    guard let navVC = sb.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {return}
                                    self.present(navVC, animated: true, completion: nil)
                                    
                                }
                            }
                        }
                    }
                }
                
                if userisRegistered == false {
                    self.showAlert(withTitle: "Error", message: "Please sign in with existing account")
                }
            }
        }
    }

}
