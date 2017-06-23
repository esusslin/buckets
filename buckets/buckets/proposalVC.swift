//
//  proposalVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Firebase


class proposalVC: UIViewController {
    
    var ref: DatabaseReference!
    
    var proposal: Proposal?
    
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    
    @IBOutlet weak var monthlyLbl: UILabel!
    @IBOutlet weak var monthsLbl: UILabel!
    @IBOutlet weak var slider: UISlider!
   
    @IBOutlet weak var bucketApprovedBtn: UIButton!
    @IBOutlet weak var rateSetBtn: UIButton!
    
    @IBOutlet weak var inputField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)

        ref = Database.database().reference()
        
        itemLbl.text = proposal!.item
        
        let url = URL(string: (proposal?.imageString)!)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)
            
            imageView.image = image

        }
        
        priceLbl.text = String(describing: proposal!.price)
        monthsLbl.text = String(describing: proposal!.months)
        monthlyLbl.text = String(describing: proposal!.monthly)


//            itemLbl.text = proposal?.item
        // Do any additional setup after loading the view.
    }
    
    func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
            monthlyLbl.text = amountString
//            proposal!.monthly = Double(amountString)!
            
            let monthlyDouble = ((proposal?.price)! / (proposal?.monthly)!)
            
            monthsLbl.text = String(Int(monthlyDouble))
            
//            let monthlyInt = Int(monthlyDouble)
            monthlyLbl.text = ""
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rateSetBtn_pressed(_ sender: Any) {
        
        
        
        
        
        var rate = inputField.text!
        rate.remove(at: rate.startIndex)
        print(rate)
        
        let monthVar = ((proposal!.price) / Double(rate)!)
        
        if monthVar > 14 {
            let alert = UIAlertController(title: "TOO LOW", message: "Bucket Max is 14 months - Please select a higher rate", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
                print("Alert!")
                
            }
            alert.addAction(cancelAction)
            
            
            let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.30)
            alert.view.addConstraint(height);
            self.present(alert, animated: true, completion: nil)
        }
        
        
        monthsLbl.text = String(Int(monthVar))
        slider.setValue(Float(Int(monthVar)), animated: true)
        proposal!.monthly = Double(rate)!
        
        monthlyLbl.text = String((proposal!.monthly))
        print(proposal!.monthly)
    }

    
    
    
    @IBAction func slider_changed(_ sender: UISlider) {

        
        let fixed = roundf(sender.value / 100.0) * 100.0;
        sender.setValue(fixed, animated: true)
        
        
        let monthly = proposal!.monthly
        print(fixed)
        
        print((monthly / 5.99) * 5.99)
        
    }


    @IBAction func bucketApproveBtn_pressed(_ sender: Any) {
        
        let propRefString = proposal!.key as! String
        
        
        
        let oldPropRef = self.ref.child("users").child(Auth.auth().currentUser!.uid).child("proposals").child(propRefString)
        oldPropRef.removeValue()
//       let old = self.ref.child("users").child(Auth.auth().currentUser!.uid).child("proposals").value(forKey: "item").)
        
         self.ref.child("users").child(Auth.auth().currentUser!.uid).child("buckets").childByAutoId().setValue(["item": proposal!.item, "price": proposal!.price, "imageString": proposal!.imageString, "monthly": proposal!.monthly, "months": proposal!.months, "balance": 0.0, "active": true])
       
        
        let alert = UIAlertController(title: "Bucket Approved!", message: "Bucket for \(proposal!.item) ETA: \(proposal!.months) months!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            
            print("Alert!")
            
        }
        alert.addAction(cancelAction)
        
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.30)
        alert.view.addConstraint(height);
        self.present(alert, animated: true, completion: nil)

        
    }

    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true)
    }

}







extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
