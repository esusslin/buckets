//
//  BigBucketCell.swift
//  buckets
//
//  Created by Emmet Susslin on 6/22/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class BigBucketCell: UITableViewCell {

    var bucket: Bucket?

    @IBOutlet weak var itemLbl: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var actualItemImage: UIImageView!
    @IBOutlet weak var percentLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(bucket: Bucket) {
        
        
        let url = URL(string: bucket.imageString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!
            
            actualItemImage.image = image
        }
        
        if bucket.balance < 1 {
            percentLbl.text = "0%"
            percentLbl.textColor = UIColor.red
        } else {
            let per = (bucket.balance / bucket.price) as! Double
            let per2 = Int(per * 100)
            
            if per2 < 25 {
                percentLbl.textColor = UIColor.yellow
            }
            
            if per2 < 75 {
                percentLbl.textColor = UIColor.green
            }
            
            percentLbl.text = String(per2) + "%"
        }
        
        
        itemLbl.text = bucket.item
        itemImage.image = UIImage(named: "green_bucket")
//        return cell

    
    
    }





    @IBAction func upBtn_pressed(_ sender: Any) {
        
        print("UP!")
        print(sender)
       
        
    }


    @IBAction func downBtn_pressed(_ sender: Any) {
        
        print("DOWN!")
    }

}
