//
//  BucketCell.swift
//  buckets
//
//  Created by Emmet Susslin on 6/21/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class BucketCell: UITableViewCell {
//     var delegate: myTableDelegate?
    
    var prop: Proposal?
    
    @IBOutlet weak var itemLbl: UILabel!
    
    @IBOutlet weak var percentLbl: UILabel!
    
    @IBOutlet weak var bucketImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MyTableViewCell.tapEdit(_:)))
//        addGestureRecognizer(tapGesture)
        
        
        // Initialization code
    }
    
//    func tapEdit(sender: UITapGestureRecognizer) {
//        delegate?.myTableDelegate()
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func viewDidLayoutSubviews() {
//        
//        bucketImage.layer.masksToBounds = true
//        
//        bucketImage.layer.cornerRadius = bucketImage.frame.size.width/2
//
//    }
    
    
    func bindData(prop: Proposal) {
        
        
        let url = URL(string: prop.imageString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!
            
//            actualItemImage.image = image
        }

        
       itemLbl.text = prop.item
        percentLbl.text = ""
        bucketImage.image = UIImage(named: "bucket-1")
        bucketImage.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        bucketImage.layer.masksToBounds = true
        
        bucketImage.layer.cornerRadius = bucketImage.frame.size.width/2
        //        return cell


}
}

