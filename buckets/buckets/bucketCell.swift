//
//  bucketCell.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class bucketCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bindData(proposal: Proposal) {
        
        print(proposal)
        
        print("load data?")
        
     
        
//        let url = URL(string: proposal.imageString)!
//        let data = try? Data(contentsOf: url)
//        if let imageData = data {
//            let image = UIImage(data: data!)
//            
//            itemImage.image = image
//            //            imageView.layer.cornerRadius = 8
//            itemImage.layer.shadowOpacity = 0.8
//        }
//        
    }


}
