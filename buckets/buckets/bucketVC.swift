//
//  bucketVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/21/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class bucketVC: UIViewController {

    
    var bucket: Bucket?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var percentagelbl: UILabel!
    @IBOutlet weak var microRateLbl: UILabel!
    @IBOutlet weak var monthlyLbl: UILabel!
    @IBOutlet weak var rateControl: UISegmentedControl!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLbl.text = bucket?.item
        
        let url = URL(string: (bucket?.imageString)!)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!
            
            imageView.image = image
           
        }
        
        let per = (bucket!.balance / bucket!.price) as! Double
        let per2 = Int(per * 100)
        
        percentagelbl.text = "$" + String(per2) + "%"
        monthlyLbl.text = String(bucket!.monthly)
        priceLbl.text = "$" + String(bucket!.price)
        microRateLbl.text = String(bucket!.monthly)
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segControl(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
//            microRateLbl.text = String(bucket!.monthly)
            switch sender.selectedSegmentIndex
        
            {
                case 0:
                microRateLbl.text = "$" + String(bucket!.monthly) + "0 monthly";
                case 1:
                    
                   let wkly = Double(bucket!.monthly/4)
                   let wk = Double((wkly/100)*100)
                   
                microRateLbl.text = "$" + String(wk) + "0 weekly";
                
            case 2:
                
                let dailly = Double(bucket!.monthly/30)
                let dly = Double((dailly/100)*100)
                
                microRateLbl.text = "$" + String(dly) + "0 weekly";
                
                
                default:
                break; 
        }
    }

    @IBAction func rename(_ sender: Any) {
        let alert = UIAlertController(title: "Customize this Name",
                                      message: "Add an Item",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        let textField = alert.textFields![0]
                                        
                                        self.bucket?.ref?.child("item").setValue(textField.text)

        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

    }

    
    
    
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true)
    }

}
