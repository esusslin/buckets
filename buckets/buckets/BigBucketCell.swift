//
//  BigBucketCell.swift
//  buckets
//
//  Created by Emmet Susslin on 6/22/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Firebase



class BigBucketCell: UITableViewCell {

    
    var viewController: UITableViewController?
    
    var ref: DatabaseReference!
    
    
    var bucket: Bucket?

    @IBOutlet weak var bucketDetailBtn: UIButton!
   
    @IBOutlet weak var itemLbl: UILabel!
    

    @IBOutlet weak var itemImage: UIImageView!

    @IBOutlet weak var percentLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ref = Database.database().reference()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func detailBtn_pressed(_ sender: Any) {
        
    }
    
    
    func bindData(bucket: Bucket) {
        
       

        
        let url = URL(string: bucket.imageString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!
            
//            actualItemImage.image = image
        }
        
        let per = (bucket.balance / bucket.price) as! Double
        let per2 = Int(per * 100)
        
        print("per 2")
//        print(viewController!.userBalance)
//        BucketTableVC.userBalance
        print(per2)
        if bucket.balance == 0 {
            percentLbl.text = "0%"
            percentLbl.textColor = UIColor.red
//            self.viewController.user
        } else if (per2 < 25) && (per2 > 1) {
            percentLbl.text = "$" + String(per2) + "%"
            percentLbl.textColor = UIColor.red
            balanceLbl.text = "$" + String(bucket.balance) + "0"
        }
            else if (per2 > 25) && (per2 < 75) {
            
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.yellow
            itemImage.backgroundColor = UIColor.yellow
             balanceLbl.text = "$" + String(bucket.balance) + "0"
        } else if (per2 > 75) {
            
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.red
            itemImage.backgroundColor = UIColor.red
             balanceLbl.text = "$" + String(bucket.balance) + "0"
        }
        
        print("bucket balance")
        print(bucket.balance)
        
        balanceLbl.text = "$" + String(bucket.balance) + "0"
        itemLbl.text = bucket.item
        itemImage.image = UIImage(named: "bucket")
//        return cell
//reload()
//        self.viewController?.viewDidLoad()
    
    }


    func reload() {
       self.viewController?.viewDidLoad()
    }


    @IBAction func upBtn_pressed(_ sender: Any) {
         
        
        print(userBalance)
     
        userBalance -= 1.0
        self.viewController?.viewDidAppear(true)
//          self.viewController?.title = String(userBalance)
        
        
        print("UP!!!!!!")
        
        bucket!.balance += 1.0
        print("balance!!!!!!")
       
        print(bucket!.balance)
        
        
        let per = (bucket!.balance / bucket!.price) as! Double
        let per2 = Int(per * 100)
        
        print(per2)
        
        
        print(bucket!.balance)
        
        
        if bucket!.balance < 1 {
            
//            BucketTableVC.userBalance
            
            
            print(per2)
            percentLbl.text = "0%"
            percentLbl.textColor = UIColor.red
            
//            balanceLbl.text = String(bucket!.balance)
        } else if (per2 < 25) && (per2 > 1) {
            percentLbl.text = "$" + String(per2) + "%"
            percentLbl.textColor = UIColor.red
             balanceLbl.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 25) && (per2 < 75) {
            print(per2)
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.yellow
            itemImage.backgroundColor = UIColor.yellow
             balanceLbl.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 75) {
            print(per2)
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.red
            itemImage.backgroundColor = UIColor.red
             balanceLbl.text = "$" + String(bucket!.balance) + "0"
        }


        self.viewController?.viewDidAppear(false)
        
    }


    @IBAction func downBtn_pressed(_ sender: Any) {
        
        print("DOWN!")
      
//        print(self.viewController?.viewWillAppear(false)
        self.viewController?.viewDidAppear(true)
        self.viewController?.viewDidAppear(false)
    }
    


}



//    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//        if segue.identifier == "bucketShow" {
//            let indexPath = sender as! NSIndexPath
//
//            if let nav = segue.destination as? UINavigationController {
//                let bucketVC = nav.topViewController as? bucketVC!
//
//                bucketVC?.bucket = self.bucket!
//            }
//
//        }
//    }

//extension UITableViewCell {
//    var tableView:UITableView? {
//        get {
//            if let view = self.superview {
//                if view is UITableView {
//                    return (view as! UITableView)
//                }
//            }            return nil
//        }
//    }
//    
//    var tableViewDataSource:UITableViewDataSource? {
//        get {
//            return self.tableView?.dataSource
//        }
//    }
//    
//    var tableViewDelegate:UITableViewDelegate? {
//        get {
//            return self.tableView?.delegate
//        }
//    }
//}
