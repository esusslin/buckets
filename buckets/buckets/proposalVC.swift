//
//  proposalVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit


class proposalVC: UIViewController {
    
    var proposal: Proposal?
    
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    
    @IBOutlet weak var monthlyLbl: UILabel!
    @IBOutlet weak var monthsLbl: UILabel!
    @IBOutlet weak var slider: UISlider!
   
    @IBOutlet weak var bucketApprovedBtn: UIButton!
    
    @IBOutlet weak var inputField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)

        
        
        
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
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slider_changed(_ sender: UISlider) {
        
        
        
    }

    @IBOutlet weak var bucketApproveBtn_pressed: UIButton!

    
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
