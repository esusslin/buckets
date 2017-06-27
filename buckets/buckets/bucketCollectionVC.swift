////
////  bucketVC.swift
////  Bucket1
////
////  Created by Emmet Susslin on 6/13/17.
////  Copyright © 2017 Emmet Susslin. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import Firebase
//
//class bucketCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    @IBOutlet weak var collectionView: UICollectionView!
//var ref: DatabaseReference!
//    
//   var images = ["noun1", "noun2", "noun3"]
//    
//    @IBOutlet weak var iconView: UIView!
// 
//    var itemImages = [UIImage]()
//    var fullImageView: UIImageView!
//    
////    var currentSection: Int = 0
////    var currentRow: Int = 0
//    var currentIndexPath: Int = 0
//    
//    
//    //ICON STUFF
//    @IBOutlet weak var iconViewimage: UIImageView!
//    @IBOutlet weak var upBtn: UIButton!
//    @IBOutlet weak var downBtn: UIButton!
//    @IBOutlet weak var percentLbl: UILabel!
//    
//    @IBOutlet weak var balaceLbl: UILabel!
//    @IBOutlet weak var itemImage: UIImageView!
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        ref = Database.database().reference()
//        
////        print(Auth.auth().currentUser.name)
//        let userbal = Double((userBalance * 100)/100)
//        
//     
//        self.title = "Current Balance:  " + String(userbal)
//
//        
//        let screenSize: CGRect = UIScreen.main.bounds
//        
//        iconView.center.x = view.center.x
//        iconView.center.y = view.center.y
//        
//        iconView.frame.size.width = view.frame.size.width / 2
//        
//        iconView.frame.size.height = iconView.frame.size.width
//        
////        iconView.frame.size.height = view.frame.size.height / 2
//        iconView.backgroundColor = UIColor.white
//        iconView.layer.cornerRadius = 22.0
//        iconView.alpha = 0
//
//
//        
////        let viewsDictionary = ["pic":iconViewimage, "up":upBtn, "down":downBtn, "per":percentLbl, "price":priceLbl] as [String : Any]
//        
//    
//        iconViewimage.center.x = 40
//        iconViewimage.center.y = 40
//        
//        itemImage.center.x = 40
//        itemImage.center.y = 100
//        
//        itemImage.layer.cornerRadius = 12
//        upBtn.center.x = 180
//        upBtn.center.y = 60
//        downBtn.center.x = 180
//        downBtn.center.y = 120
//        
//        percentLbl.center.x = 100
//        percentLbl.center.y = 160
//        
//
//        balaceLbl.center.x = 100
//        balaceLbl.center.y = 200
//        
//        print(upBtn.center)
//        print(downBtn.center)
//        
// 
//        
//        
//        
//        self.view.addSubview(iconView)
//        
//        for a in buckets {
//        let url = URL(string: a.imageString)!
//        let data = try? Data(contentsOf: url)
//        if let imageData = data {
//            let image = UIImage(data: data!)!
//            
//            itemImages.append(image)
//            }
//
//            
//        }
//
//        
//     
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
//
//        
//        let dismissWihtTap = UITapGestureRecognizer(target: self, action: #selector(hidicon))
//        iconView.addGestureRecognizer(dismissWihtTap)
//
//
//
//        
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        myBuckets.removeAll()
//
//        self.collectionView.reloadData()
//        print("ITEM IMAGES COUNT")
//       print(itemImages.count)
//    }
//    
//
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        var frame = collectionView.frame
//        frame.size.height = self.view.frame.size.height / 2
//        frame.size.width = self.view.frame.size.width / 2
//        frame.origin.x = 0
//        frame.origin.y = 0
//        collectionView.frame = frame
////        fullImageView.frame = collectionView.frame
//    }
//    
//    
//    
//    @IBAction func upBtn_pressed(_ sender: Any) {
//        print(userBalance)
//        
//        userBalance -= 1.0
////        print(currentIndex)
//        
//     let bucket = buckets[currentIndexPath]
//        
//        bucket.balance += 1.0
//        
//        print(bucket.balance)
//        
//        let per = (bucket.balance / bucket.price) as! Double
//        let per2 = Int(per * 100)
//        
//        let userbal = Double((userBalance * 100)/100)
//        
//        
//        self.title = "Checking Balance:  " + String(userbal)
//        
//        
//        
//        if bucket.balance < 1 {
//            
//            
//            print(per2)
//            percentLbl.text = "0%"
//            percentLbl.textColor = UIColor.red
//            iconViewimage.backgroundColor = UIColor.red
//            
//        } else if (per2 < 25) && (per2 > 1) {
//            percentLbl.text = String(per2) + "%"
//            percentLbl.textColor = UIColor.red
//            iconViewimage.backgroundColor = UIColor.red
//            //           cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
//        } else if (per2 > 25) && (per2 < 75) {
//            print(per2)
//            percentLbl.text = String(per2) + "%"
//            percentLbl.textColor = UIColor.yellow
//            iconViewimage.backgroundColor = UIColor.yellow
//            //            cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
//        } else if (per2 > 75) {
//            print(per2)
//            percentLbl.text = String(per2) + "%"
//            percentLbl.textColor = UIColor.red
//            
//            iconViewimage.backgroundColor = UIColor.green
//            
//        }
//        
//        balaceLbl.text = "$ " + String(bucket.balance) + " of " + "$ " + String(bucket.price)
//        
////        collectionView.cellForItem(at: currentIndex)
//        
//        collectionView.reloadData()
//    }
//
//    
//    @IBAction func downBtn_pressed(_ sender: Any) {
//        
//        
//    }
//    
//
//    
//    
//    
//    
//    
//    
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return itemImages.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! customCell
//        
//        cell.layer.cornerRadius = 12
//        cell.layer.borderWidth = 1.5
//        cell.layer.borderColor = UIColor.white.cgColor
//        
//        let a = buckets[indexPath.row]
//        
////        currentRow = indexPath.row
////        currentSection = indexPath.section
//        
//        print("INDEX PATH")
//        print(indexPath)
//        let url = URL(string: a.imageString)!
//        let data = try? Data(contentsOf: url)
//        if let imageData = data {
//            let image = UIImage(data: data!)!
//            
//             cell.imageView.image = image
//        }
//
//        cell.iconImageView.image = UIImage(named: "bucket")
//        
//        let per = (a.balance / a.price) as! Double
//        let per2 = Int(per * 100)
//        
//        if a.balance < 1 {
//            
//            
//            
//            cell.percentlabel.text = "0%"
//            cell.percentlabel.textColor = UIColor.red
//            
//        } else if (per2 < 25) && (per2 > 1) {
//            cell.percentlabel.text = "$" + String(per2) + "%"
//            cell.percentlabel.textColor = UIColor.red
////           cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
//        } else if (per2 > 25) && (per2 < 75) {
//           
//            cell.percentlabel.text = String(per2) + "%"
//            cell.percentlabel.textColor = UIColor.yellow
//            cell.iconImageView.backgroundColor = UIColor.yellow
////            cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
//        } else if (per2 > 75) {
//           
//            cell.percentlabel.text = String(per2) + "%"
//           cell.percentlabel.textColor = UIColor.red
//            cell.iconImageView.backgroundColor = UIColor.red
//           
//        }
//        
//        
//        return cell
//    }
//    
//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! customCell
//        
//        print(indexPath)
//        print(indexPath.section)
//        print(indexPath.row)
//        
//        currentIndexPath = indexPath.row
//        
//       let buck = buckets[indexPath.row]
//        self.showBucket(bucket: buck)
//  
////        currentBucket = buckets[indexPath.row]
//    }
//
//    
//    func showBucket(bucket: Bucket) {
//        
//        let url = URL(string: bucket.imageString)!
//        let data = try? Data(contentsOf: url)
//        if let imageData = data {
//            let image = UIImage(data: data!)!
//            
//            itemImage.image = image
//        }
//
//        
//        let per = (bucket.balance / bucket.price) as! Double
//        let per2 = Int(per * 100)
//        
//        balaceLbl.text = "$ " + String(bucket.balance) + " of " + "$ " + String(bucket.price)
//        
//        
//        if bucket.balance < 1 {
//            
//            
//            print(per2)
//            percentLbl.text = "0%"
//            percentLbl.textColor = UIColor.red
//            iconViewimage.backgroundColor = UIColor.red
//            
//        } else if (per2 < 25) && (per2 > 1) {
//            percentLbl.text = "$" + String(per2) + "%"
//            percentLbl.textColor = UIColor.red
//            iconViewimage.backgroundColor = UIColor.red
//            //           cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
//        } else if (per2 > 25) && (per2 < 75) {
//            print(per2)
//            percentLbl.text = String(per2) + "%"
//            percentLbl.textColor = UIColor.yellow
//            iconViewimage.backgroundColor = UIColor.yellow
//            //            cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
//        } else if (per2 > 75) {
//            print(per2)
//            percentLbl.text = String(per2) + "%"
//            percentLbl.textColor = UIColor.red
//
//            iconViewimage.backgroundColor = UIColor.green
//            
//        }
//
//
//        
//      iconView.transform = CGAffineTransform(scaleX: 0, y: 0)
//       iconView.contentMode = .scaleAspectFit
//        
//        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations:{[unowned self] in
//            
////            self.iconView.image = image
//            self.iconView.alpha = 1
//            self.iconView.transform = CGAffineTransform(scaleX: 1, y: 1)
//            
//            }, completion: nil)
//    }
////
////    
////    
////    
//    func hidicon() {
//
//        
//        
//        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations:{[unowned self] in
//            self.iconView.alpha = 0
//            }, completion: nil)
//    }
//    
////    collec
//    
//
//
//
//}
