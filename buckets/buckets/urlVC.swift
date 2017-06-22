//
//  urlVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//


//// 1
//let rootRef = FIRDatabase.database().reference()
//
//// 2
//let childRef = FIRDatabase.database().reference(withPath: "grocery-items")
//
//// 3
//let itemsRef = rootRef.child("grocery-items")
//
//// 4
//let milkRef = itemsRef.child("milk")
//
//// 5
//print(rootRef.key)   // prints: ""
//print(childRef.key)  // prints: "grocery-items"
//print(itemsRef.key)  // prints: "grocery-items"
//print(milkRef.key)   // prints: "milk"

import UIKit
import Alamofire
import Firebase

class urlVC: UIViewController {
    
     var ref: DatabaseReference!
    
    
    @IBOutlet weak var urlTF: UITextField!
    @IBOutlet weak var submitURLBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref = Database.database().reference()
        
    }
    
    func queryone() {
        
        var proposals: [Proposal] = []
        var prop: Proposal?
        let userID = Auth.auth().currentUser?.uid
        
//        let key = self.ref.child("users").child(userID!).child("proposals").key
//        print(key)
//        
//        let updateProp = ["uid": userID,
//                    "item": "Callaway Men's Strata Complete Golf Club Set with Bag (12-Piece)",
//                    "price": 199.00
//        ] as [String : Any]
//        
//        let childUpdates = ["/users/\(userID)/proposals/\(key)": updateProp
//        ]
        
//        self.ref.updateChildValues(childUpdates)

        self.ref.child("users").child(userID!).child("proposals").observe(.value, with: { snapshot in
            
            for item in snapshot.children {

                let prop = Proposal(snapshot: item as! DataSnapshot)
                proposals.append(prop)
            }
            
            for p in proposals {
                if p.item == "Callaway Men's Strata Complete Golf Club Set with Bag (12-Piece)" {
                    prop = p
                }
            }

            print(prop?.item)
             print(prop?.price)
        })



    }
    
  

    @IBAction func submitBtn_pressed(_ sender: Any) {
      postSemantics(url: self.urlTF.text!)
        queryone()
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
