//
//  bucketCell.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class bucketCell: UITableViewCell {

    @IBOutlet weak var itemLbl: UILabel!

   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    func bindProposals(proposal: Proposal) {
//        
//        print(proposal)
//        
//        print("load data?")
//        
//     itemLbl.text = proposal.item
//        
////        let url = URL(string: proposal.imageString)!
////        let data = try? Data(contentsOf: url)
////        if let imageData = data {
////            let image = UIImage(data: data!)
////            
////            itemImage.image = image
////            //            imageView.layer.cornerRadius = 8
////            itemImage.layer.shadowOpacity = 0.8
////        }
////        
//    }
//    
//    func bindBuckets(bucket: Bucket) {
//        
//        print(bucket)
//        
//        print("load data?")
//        
//        itemLbl.text = bucket.item
//        
//        //        let url = URL(string: proposal.imageString)!
//        //        let data = try? Data(contentsOf: url)
//        //        if let imageData = data {
//        //            let image = UIImage(data: data!)
//        //
//        //            itemImage.image = image
//        //            //            imageView.layer.cornerRadius = 8
//        //            itemImage.layer.shadowOpacity = 0.8
//        //        }
//        //        
//    }



}