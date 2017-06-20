//
//  loginVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import FirebaseAuth

class loginVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var signinbtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func loginBtn_pressed(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if (user != nil) {
                print("user saved")
                print(user?.email)
                
                let user = Auth.auth().currentUser
                
                 let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "welcomeVC") as! welcomeVC
                 welcomeVC.email = user?.email
                
                self.present(welcomeVC, animated: true, completion: nil)
            } else {
                print(error)
            }
        }
    }

    @IBAction func signInBtn_pressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
           if (user != nil) {
             let user = Auth.auth().currentUser
            
            let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeBackVC") as! WelcomeBackVC
            self.present(welcomeVC, animated: true, completion: nil)
        } else {
            print(error)
        }

        }
    
    }



}
