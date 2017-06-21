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

class urlVC: UIViewController {
    
     var ref: DatabaseReference!
    
    
    @IBOutlet weak var urlTF: UITextField!
    @IBOutlet weak var submitURLBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        reloadProposals()
    }
    
    func reloadProposals() {
        
        let userID = Auth.auth().currentUser?.uid
        
        
            self.ref.child("users").child(userID!).child("proposals").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print("snapshot!")
            
            
                if let snapDict = snapshot.value as? [String:AnyObject] {
            
                        print(snapDict)
            
                        for a in snapDict {
            
                        if let b = a.value as? [String:AnyObject] {
            
                            let prop = Proposal(item: b["item"] as! String, price: b["price"] as! Double, imageString: b["imageString"] as! String)
            
                                myProposals.append(prop)
                                print("--------------")
                                print(myProposals)
                        }
    
            
            
            
                        }
                }
            })

        }



    @IBAction func submitBtn_pressed(_ sender: Any) {
        postSemantics(url: self.urlTF.text!)
        
    }
    
    
    func postSemantics(url: String) {
        let userID = Auth.auth().currentUser?.uid
        
        let parameters: Parameters = ["url": url]
        
        Alamofire.request("http://localhost:3000/proposals/url", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON() { response in
                
                if let JSON = response.result.value as? [String:Any] {
                    print(JSON)
                    
                    
                    
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("proposals").childByAutoId().setValue(["item": JSON["item"], "price": JSON["price"], "monthly": JSON["monthly"], "months": JSON["months"],"imageString": JSON["imageString"]])
                    
                                self.reloadProposals()
                                let p = myProposals.last!
//                                print("--------------")
//                                print("--------------")
//                                print("--------------")
//                                print(p.item)
//                                print(p.price)
                    
            
                                let alert = UIAlertController(title: "New Proposal: \(p.item) ..!", message: "Pay for this item in 8 months at \(p.monthly)", preferredStyle: .alert)
            
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
