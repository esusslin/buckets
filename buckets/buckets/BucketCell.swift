//
//  BucketCell.swift
//  buckets
//
//  Created by Emmet Susslin on 6/21/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class BucketCell: UITableViewCell {
    
    
    
    @IBOutlet weak var itemLbl: UILabel!
    
    @IBOutlet weak var percentLbl: UILabel!
    
    @IBOutlet weak var bucketImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
