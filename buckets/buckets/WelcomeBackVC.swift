//
//  WelcomeBackVC.swift
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


class WelcomeBackVC: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var welcomebacklbl: UILabel!
    @IBOutlet weak var item: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var monthly: UITextField!
    @IBOutlet weak var months: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var loadProps: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        welcomebacklbl.text = "WElcome back \(Auth.auth().currentUser!.email!)"

        // Do any additional setup after loading the view.
    }

    @IBAction func createBtn_pressed(_ sender: Any) {
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("proposals").childByAutoId().setValue(["item": item.text, "price": price.text, "monthly": monthly.text, "months": months.text])
        
//        setValue(["item": item.text, "price": price.text, "monthly": monthly.text, "months": months.text])

    }
    
    @IBAction func loadProps_pressed(_ sender: Any) {
        
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).child("proposals").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print(snapshot)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    


}
