//
//  urlVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//



import UIKit
import Alamofire
import Firebase
import FirebaseAuth

class urlVC: UIViewController {
    
     var ref: DatabaseReference!
    
    
    @IBOutlet weak var urlTF: UITextField!
    @IBOutlet weak var submitURLBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref = Database.database().reference()
        
    }
    

    @IBAction func logoutsBtn_pressed(_ sender: Any) {
        
//        let firebaseAuth = Auth.auth()
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! loginVC
        
        self.present(vc, animated: true, completion: nil)

        
        
    }
    

    @IBAction func btn(_ sender: Any) {
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").setValue(549.20)
        
    }

    @IBAction func submitBtn_pressed(_ sender: Any) {
      postSemantics(url: self.urlTF.text!)
//        queryone()
    }
    
    
    func postSemantics(url: String) {
        let userID = Auth.auth().currentUser?.uid
        
        let parameters: Parameters = ["url": url]
        
        Alamofire.request("http://localhost:3000/proposals/url", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON() { response in
                
                if let JSON = response.result.value as? [String:Any] {
//                    print(JSON)
                    
                let newitemString = JSON["item"] as! String
                    
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("proposals").childByAutoId().setValue(["item": JSON["item"], "price": JSON["price"], "imageString": JSON["imageString"], "monthly": JSON["monthly"], "months": 8, "balance": 0.0, "active": false])
                    
                    let alert = UIAlertController(title: "New Proposal: \(JSON["item"]) ..!", message: "Start this bucket today))", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                        
                        
                    }
                    alert.addAction(cancelAction)
                    
                    
                    let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.30)
                    alert.view.addConstraint(height);
                    self.present(alert, animated: true, completion: nil)

                        }
        }
        
    }

}
