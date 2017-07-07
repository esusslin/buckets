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
    
    @IBOutlet weak var playBtn: UIButton!

    @IBOutlet weak var itemImage: UIImageView!

    @IBOutlet weak var percentLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    @IBOutlet weak var progBar: UIProgressView!
    
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
    @IBAction func playBtn_pressed(_ sender: Any) {
        
        
        
        if bucket!.active {
            print("hello?")
            bucket!.active = false
            let imge = UIImage(named: "play")
            
            let fadedImg = imge?.alpha(0.7)
            
            playBtn.imageView?.image = fadedImg

        } else {
        
//        if bucket!.active == false {
            print("hello?????")
            bucket!.active = true
            let imge = UIImage(named: "pause")
            
            let fadedImg = imge?.alpha(0.7)
            
            playBtn.imageView?.image = fadedImg
         
        }

        
        
    }
    
    
    func bindData(bucket: Bucket) {
        
        playBtn.center = itemImage.center
        
        let url = URL(string: bucket.imageString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!

        }
        
        if bucket.active == true {
            let imge = UIImage(named: "pause")
            
            let fadedImg = imge?.alpha(0.6)
            
//                playBtn.image = fadedImg
            playBtn.imageView?.image = fadedImg
        }
        
        if bucket.active == false {
            let imge = UIImage(named: "play")
            
            let fadedImg = imge?.alpha(0.6)
            
            playBtn.imageView?.image = fadedImg
//            playBtn.image = fadedImg
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapButton(_:)))
        tapGesture.numberOfTapsRequired = 1

       
        
        let per = (bucket.balance / bucket.price) as! Double
        let per2 = Int(per * 100)
        
        print("per 2")

        print(per2)
        if bucket.balance == 0 {
            percentLbl.text = "0%"
            percentLbl.textColor = UIColor.red
             progBar.progress = 0.0
//            self.viewController.user
        } else if (per2 < 25) && (per2 > 1) {
            percentLbl.text = "$" + String(per2) + "%"
            percentLbl.textColor = UIColor.red
            balanceLbl.text = "$" + String(bucket.balance) + "0"
            print("PROG")
            progBar.progress = Float(per)
            progBar.progressTintColor = UIColor.red
        }
            else if (per2 > 25) && (per2 < 75) {
            
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.black
//            itemImage.backgroundColor = UIColor.yellow
            
            print("PROG")
            progBar.progress = Float(per)
            progBar.progressTintColor = UIColor.yellow
             balanceLbl.text = "$" + String(bucket.balance) + "0"
        } else if (per2 > 75) {
            
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.green
//            itemImage.backgroundColor = UIColor.red
             balanceLbl.text = "$" + String(bucket.balance) + "0"
            
            print("PROG")
            progBar.progress = Float(per)
            progBar.progressTintColor = UIColor.green
        }
        
    
        
        balanceLbl.text = "$" + String(bucket.balance) + "0"
        itemLbl.text = bucket.item
        itemImage.image = UIImage(named: "bucket-1")
        itemImage.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        
        itemImage.layer.masksToBounds = true
        
        
        itemImage.layer.cornerRadius = itemImage.frame.size.width/2
        
       

    
    }




    @IBAction func upBtn_pressed(_ sender: Any) {
         
        
        print(userBal)
        print(userBalance)
        
        
        self.viewController?.viewDidAppear(true)
//          self.viewController?.title = String(userBalance)
        

        bucket!.balance += 1.0
       
//        localBal = balanceLbl.text
       
        print(bucket!.balance)
        
        
        let per = (bucket!.balance / bucket!.price) as! Double
        let per2 = Int(per * 100)
        
        
        if bucket!.balance < 1 {
            
//            let wk = round(Double((wkly/100)*100))
            
            
            print(per2)
            percentLbl.text = "0%"
            percentLbl.textColor = UIColor.red
            
        } else if (per2 < 25) && (per2 > 1) {
            percentLbl.text = "$" + String(per2) + "%"
            percentLbl.textColor = UIColor.red
             balanceLbl.text = "$" + String(Double((bucket!.balance/100)*100)) + "0"
              print("PROG")
             progBar.progress = Float(per)
            print(progBar.progress)
        } else if (per2 > 25) && (per2 < 75) {
            print(per2)
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.black
//            itemImage.backgroundColor = UIColor.yellow
             balanceLbl.text = "$" + String(Double((bucket!.balance/100)*100)) + "0"
              print("PROG")
             progBar.progress = Float(per)
                    print(progBar.progress)
        } else if (per2 > 75) {
            print(per2)
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.green
            itemImage.backgroundColor = UIColor.red
             balanceLbl.text = "$" + String(Double((bucket!.balance/100)*100)) + "0"
            print("PROG")
             progBar.progress = Float(per)
                    print(progBar.progress)
        }

        let buckRef = bucket!.ref
        
        
        
        buckRef?.child("balance").setValue(bucket!.balance)
        
       
        userBalance -= 1.0

        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").setValue(userBalance)
        

        self.viewController?.viewDidAppear(false)
        
    }
    
    func tapButton(_ sender: UITapGestureRecognizer) {
        print("HELLP!")
    }



    @IBAction func downBtn_pressed(_ sender: Any) {
        
        print("DOWN!")
      
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        if segue.identifier == "bucketShow" {
            
            print("BUCKET!")

            
        }
    }

}

extension UIImage{
    
    func alpha(_ value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}


