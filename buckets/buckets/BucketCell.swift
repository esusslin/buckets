//
//  BucketCell.swift
//  buckets
//
//  Created by Emmet Susslin on 6/21/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class BucketCell: UITableViewCell {
    
    
    var prop: Proposal?
    
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
    
    func bindData(prop: Proposal) {
        
        
        let url = URL(string: prop.imageString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!
            
//            actualItemImage.image = image
        }

        
       itemLbl.text = prop.item
        percentLbl.text = ""
        bucketImage.image = UIImage(named: "grey_bucket")
        //        return cell


}
}


//if indexPath.section == 0 {
//    print("loading buckets..")
//    
//    let cell = tableView.dequeueReusableCell(withIdentifier: "bigBucketCell", for: indexPath) as! BigBucketCell
//    
//    cell.bucket = buckets[indexPath.row]
//    
//    cell.bindData(bucket: cell.bucket!)
//    return cell
//}
//
//if indexPath.section == 1 {
//    print("loading props..")
//    let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell
//    
//    cell.prop = proposals[indexPath.row]
//    
//    cell.bindData(prop: cell.prop!)
//    
//    return cell
//}
