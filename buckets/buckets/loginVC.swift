//
//  loginVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class loginVC: UIViewController {
    

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

//         1
        Auth.auth().addStateDidChangeListener() { auth, user in
//             2
            if user != nil {
                
                print("USER PRESENT")
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
                            vc.selectedIndex = 1
                
                            self.present(vc, animated: true, completion: nil)
            }
        }

        // Do any additional setup after loading the view.
    }


    @IBAction func loginBtn_pressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!,
                               password: passwordTextField.text!)
    }
    
//        let alert = UIAlertController(title: "Welcome Back",
//                                      message: "Please Enter your Credentials",
//                                      preferredStyle: .alert)
//        
//        let saveAction = UIAlertAction(title: "Login",
//                                       style: .default) { action in
//                                        
//                                        // 1
//                                        let emailField = alert.textFields![0]
//                                        let passwordField = alert.textFields![1]
//                                        
//                                        // 2
//                                        Auth.auth().createUser(withEmail: emailField.text!,
//                                                               password: passwordField.text!) { user, error in
//                                                                
//                                                                if (user != nil) {
//                                                                                    print("user saved")
//                                                                                    print(user?.email)
//                                                                    
//                                                                                    print(user?.displayName)
//                                                                    
//                                                                    
//                                                                                     let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "welcomeVC") as! welcomeVC
//                                                                                     welcomeVC.email = user?.email
//                                                                    
//                                                                    
//                                                                                    self.present(welcomeVC, animated: true, completion: nil)
//                                                                                } else {
//                                                                                    print(error)
//                                                                                }
//
//                                                                    
//                                                                
////                                                                if error == nil {
////
////
////                                                                    // 3
////                                                                    Auth.auth().signIn(withEmail: emailField.text!,
////                                                                                       password: passwordField.text!)
////                                                                }
//                                        }
//                                        
//                                        
//                                        
//        }
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .default)
//        
//        alert.addTextField { textEmail in
//            textEmail.placeholder = "Enter your email"
//        }
//        
//        alert.addTextField { textPassword in
//            textPassword.isSecureTextEntry = true
//            textPassword.placeholder = "Enter your password"
//        }
//        
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        
//        present(alert, animated: true, completion: nil) 
//
    
//       Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
//        
//        
//            if (user != nil) {
//                print("user saved")
//                print(user?.email)
//
//                print(user?.displayName)
//                
//                
//                 let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "welcomeVC") as! welcomeVC
//                 welcomeVC.email = user?.email
//               
//                
//                self.present(welcomeVC, animated: true, completion: nil)
//            } else {
//                print(error)
//            }
//        }
//    }

    @IBAction func signInBtn_pressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        
                                        // 1
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        // 2
                                        Auth.auth().createUser(withEmail: emailField .text!,
                                                                   password: passwordField.text!) { user, error in
                                                                    if error == nil {
                                                                        // 3
                                                                        Auth.auth().signIn(withEmail: emailField .text!,
                                                                                               password: passwordField.text!)
                                                                    }
                                        }
                                        
                                        
                                        
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }


//        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
//            
//           if (user != nil) {
//             let user = Auth.auth().currentUser
//            
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
//            vc.selectedIndex = 1
//            
//            self.present(vc, animated: true, completion: nil)        } else {
//            print(error)
//        }
//
//        }
    
//    }



}
