//
//  welcomeVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth



class welcomeVC: UIViewController {
    
    var ref: DatabaseReference!

    var name: String?
    var email: String?
    @IBOutlet weak var itemTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var monthlyTF: UITextField!
    @IBOutlet weak var monthsTF: UITextField!
    @IBOutlet weak var createPropBTN: UIButton!
    
    @IBOutlet weak var welcomeLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        print(Auth.auth().currentUser)
        
        welcomeLbl.text = "Welcome \(self.email!), \(self.name)"
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createBtn_pressed(_ sender: Any) {
        
        print(Auth.auth().currentUser!.uid)
        print(itemTF.text)
        print(priceTF.text)
         print(monthlyTF.text)
        print(monthsTF.text)
       
        let userID = Auth.auth().currentUser?.uid
//        child("users").child(Auth.auth().currentUser!.uid).
      self.ref.child("users").child(Auth.auth().currentUser!.uid).child("proposals").childByAutoId().setValue(["item": itemTF.text, "price": priceTF.text, "monthly": monthlyTF.text, "months": monthsTF.text])
        
        
        
        
    }

   

}
