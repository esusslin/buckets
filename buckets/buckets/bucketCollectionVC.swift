//
//  bucketVC.swift
//  Bucket1
//
//  Created by Emmet Susslin on 6/13/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Alamofire

class bucketCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    
   var images = ["noun1", "noun2", "noun3"]
    
    @IBOutlet weak var iconView: UIView!
 
    var itemImages = [UIImage]()
    var fullImageView: UIImageView!
    
    
    
    
    //ICON STUFF
    @IBOutlet weak var iconViewimage: UIImageView!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var percentLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        iconView.center.x = view.center.x
        iconView.center.y = view.center.y
        
        iconView.frame.size.width = view.frame.size.width / 2
        
        iconView.frame.size.height = iconView.frame.size.width
        
//        iconView.frame.size.height = view.frame.size.height / 2
        iconView.backgroundColor = UIColor.white
        iconView.layer.cornerRadius = 22.0
        iconView.alpha = 0
        
        
//        iconView.addSubview(iconViewimage)
//        iconView.addSubview(upBtn)
//        iconView.addSubview(downBtn)
//         iconView.addSubview(percentLbl)
//        iconView.addSubview(priceLbl)
//
        priceLbl.textColor = UIColor.white
        percentLbl.textColor = UIColor.white
        
        let viewsDictionary = ["pic":iconViewimage, "up":upBtn, "down":downBtn, "per":percentLbl, "price":priceLbl] as [String : Any]
        
//        nextLbl.translatesAutoresizingMaskIntoConstraints = false
//        arrowPic.translatesAutoresizingMaskIntoConstraints = false
//        distLbl.translatesAutoresizingMaskIntoConstraints = false
        
//        iconView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[pic(40)]-20-[label]-20-|",
//                                                                  options: [],
//                                                                  metrics: nil,
//                                                                  views: viewsDictionary))
//        
        iconViewimage.center.x = 40
        iconViewimage.center.y = 40
        upBtn.center.x = 180
        upBtn.center.y = 60
        downBtn.center.x = 180
        downBtn.center.y = 120
        
        print(upBtn.center)
        print(downBtn.center)
        
        
//        print(iconViewimage.center)
//        
//        print(iconView.center)
//
//        iconViewimage.frame.size.width = view.frame.size.width / 2
//        
//        iconViewimage.frame.size.height = iconView.frame.size.width / 3
//        iconViewimage.frame.size.width = iconViewimage.frame.size.height
//        iconViewimage.backgroundColor = UIColor.white
        
        
        
        
        
        self.view.addSubview(iconView)
        
        for a in buckets {
        let url = URL(string: a.imageString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!
            
            itemImages.append(image)
            }

            
        }

        
     
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
//        fullImageView = UIImageView()
//        fullImageView.contentMode = .scaleAspectFit
//        fullImageView.backgroundColor = UIColor.lightGray
//        fullImageView.isUserInteractionEnabled = true
//        fullImageView.alpha = 0
//        self.view.addSubview(fullImageView)
        
        
        let dismissWihtTap = UITapGestureRecognizer(target: self, action: #selector(hidicon))
        iconView.addGestureRecognizer(dismissWihtTap)



        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myBuckets.removeAll()

        
        print("ITEM IMAGES COUNT")
       print(itemImages.count)
    }
    


    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var frame = collectionView.frame
        frame.size.height = self.view.frame.size.height / 2
        frame.size.width = self.view.frame.size.width / 2
        frame.origin.x = 0
        frame.origin.y = 0
        collectionView.frame = frame
//        fullImageView.frame = collectionView.frame
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! customCell
        
        cell.layer.cornerRadius = 12
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.white.cgColor
        
        let a = buckets[indexPath.row]
        
        let url = URL(string: a.imageString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!
            
             cell.imageView.image = image
        }

        cell.iconImageView.image = UIImage(named: "bucket")
        
        let per = (a.balance / a.price) as! Double
        let per2 = Int(per * 100)
        
        if a.balance < 1 {
            
            
            print(per2)
            cell.percentlabel.text = "0%"
            cell.percentlabel.textColor = UIColor.red
            
        } else if (per2 < 25) && (per2 > 1) {
            cell.percentlabel.text = "$" + String(per2) + "%"
            cell.percentlabel.textColor = UIColor.red
//           cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 25) && (per2 < 75) {
            print(per2)
            cell.percentlabel.text = String(per2) + "%"
            cell.percentlabel.textColor = UIColor.yellow
            cell.iconImageView.backgroundColor = UIColor.yellow
//            cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 75) {
            print(per2)
            cell.percentlabel.text = String(per2) + "%"
           cell.percentlabel.textColor = UIColor.red
            cell.iconImageView.backgroundColor = UIColor.red
           
        }

        
        

//        cell.imageView.image = itemImages[indexPath.row]
        
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! customCell
       let buck = buckets[indexPath.row]
            self.showBucket(bucket: buck)
  
        print(indexPath)
    }

    
    func showBucket(bucket: Bucket) {
        
//        iconViewimage.center.x = iconView.center.x
//        iconViewimage.center.y = iconView.center.y
//        

        
        iconView.transform = CGAffineTransform(scaleX: 0, y: 0)
       iconView.contentMode = .scaleAspectFit
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations:{[unowned self] in
            
//            self.iconView.image = image
            self.iconView.alpha = 1
            self.iconView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            }, completion: nil)
    }
//
//    
//    
//    
    func hidicon() {

        
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations:{[unowned self] in
            self.iconView.alpha = 0
            }, completion: nil)
    }
    
//    collec
    



}
