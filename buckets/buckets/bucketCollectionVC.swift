//
//  bucketVC.swift
//  Bucket1
//
//  Created by Emmet Susslin on 6/13/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class bucketCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
var ref: DatabaseReference!
    
    var proposals: [Proposal] = []
    
    var buckets: [Bucket] = []
    
   var images = ["noun1", "noun2", "noun3"]
    
    @IBOutlet weak var iconView: UIView!
 
    var delegate: UICollectionViewDelegate!
    var fullImageView: UIImageView!
    
//    var currentSection: Int = 0
//    var currentRow: Int = 0
    var currentIndexPath: Int = 0
    
    var longPressGesture : UILongPressGestureRecognizer!
    
    //ICON STUFF
    @IBOutlet weak var iconViewimage: UIImageView!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var percentLbl: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var balaceLbl: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
        let userID = Auth.auth().currentUser?.uid
        
        self.ref.child("users").child(userID!).child("buckets").observe(.value, with: { snapshot in
            
            var newBuckets: [Bucket] = []
            
            for item in snapshot.children {
                // 4
                let buck = Bucket(snapshot: item as! DataSnapshot)
                newBuckets.append(buck)
            }
            
            // 5
            self.buckets = newBuckets
            self.collectionView.reloadData()
           
            
            
        })
        
        
        
        self.ref.child("users").child(userID!).child("proposals").observe(.value, with: { snapshot in
            
            var newProposals: [Proposal] = []
            
            for item in snapshot.children {
                // 4
                let prop = Proposal(snapshot: item as! DataSnapshot)
                newProposals.append(prop)
            }
            
            // 5
            self.proposals = newProposals
           self.collectionView.reloadData()
        })
        
        let balanceRef = self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance")
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").observe(.value, with: { snapshot in
            
            //        balanceRef.observe(.value, with: { snapshot in
            
            print("balance observing")
            print(snapshot.value!)
            
            userBal = snapshot.value! as! Double
            userBalance = snapshot.value! as! Double
            
            self.title = "$" + String(userBal) + "0"

            print(userBal)
            print(userBalance)
            
        })

        
        let screenSize: CGRect = UIScreen.main.bounds
        
        iconView.center.x = view.center.x
        iconView.center.y = view.center.y
        
        iconView.frame.size.width = view.frame.size.width / 2
        
        iconView.frame.size.height = iconView.frame.size.width
        
        iconView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        
        
        
        iconView.layer.cornerRadius = 22.0
        iconView.alpha = 0
  
    
        itemImage.layer.masksToBounds = true
        itemImage.center.x = 100
        itemImage.center.y = 100
        cancelBtn.center.x = 100
        cancelBtn.center.y = 100
        
        itemImage.layer.cornerRadius = 12
        upBtn.center.x = 180
        upBtn.center.y = 60
        downBtn.center.x = 180
        downBtn.center.y = 120
        
        percentLbl.center.x = 100
        percentLbl.center.y = 160
        
        
        
        

        balaceLbl.center.x = 100
        balaceLbl.center.y = 200
        
        print(upBtn.center)
        print(downBtn.center)
        
 
        
        
        
        self.view.addSubview(iconView)
        


        
     
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        self.collectionView?.addGestureRecognizer(longPressGesture)

        
    }
    @IBAction func cancelBtn_pressed(_ sender: Any) {
        hidicon()
    }
    
    @IBAction func hideViewX(_ sender: Any) {
        
        hidicon()
    }
    
    
    
    @IBAction func days_pass(_ sender: Any) {
        for b in buckets {
            
            if b.period == "daily" {
                b.balance += b.rate
                b.ref?.child("balance").setValue(b.balance)
                
                userBalance -= b.rate
                
                
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").setValue(userBalance)
            }
        }
        
        self.collectionView.reloadData()
        
    }
    
    
    @IBAction func months_pass(_ sender: Any) {
        
        
        for b in buckets {
            
            if b.period == "daily" {
                
                let thirty = round((b.rate * 30))
                b.balance += thirty
                
                
                b.ref?.child("balance").setValue(b.balance)
                
                userBalance -= thirty
                
                
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").setValue(userBalance)
            }
        }
        
        for b in buckets {
            
            if b.period == "monthly" {
                
                //                let thirty = round((b.rate * 30))
                b.balance += b.rate
                b.ref?.child("balance").setValue(b.balance)
                
                userBalance -= b.rate
                
                
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").setValue(userBalance)
            }
        }
        
        for b in buckets {
            
            if b.period == "weekly" {
                
                let quarterly = round((b.rate * 4))
                b.balance += quarterly
                b.ref?.child("balance").setValue(b.balance)
                
                userBalance -= quarterly
                
                
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").setValue(userBalance)
            }
        }
        
        
        self.collectionView.reloadData()

        
    }

    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
                
//                print(selectedIndexPath)
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            print(gesture.location(in: view))
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
           
            let alert = UIAlertController(title: "Combine these buckets?", message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "YES", style: .cancel) { (action) in
                
                print("Alert!")
                
            }
            alert.addAction(cancelAction)
            
            
            let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.18)
            alert.view.addConstraint(height);
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()

        

        }
    }
    
    internal func invalidationContextForInteractivelyMovingItems(targetIndexPaths: [NSIndexPath],
                                                                          withTargetPosition targetPosition: CGPoint,
                                                                          previousIndexPaths: [NSIndexPath],
                                                                          previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        
        var context = invalidationContextForInteractivelyMovingItems(targetIndexPaths: targetIndexPaths,
                                                                           withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths,
                                                                           previousPosition: previousPosition)
        
//        self.delegate.collectionView!(self.collectionView!, moveItemAtIndexPath: previousIndexPaths[0],
//                                       toIndexPath: targetIndexPaths[0])
        
        return context
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                                 moveItemAt sourceIndexPath: IndexPath,
                                 to destinationIndexPath: IndexPath) {
        // move your data order
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myBuckets.removeAll()

        self.collectionView.reloadData()

    }
    


    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var frame = collectionView.frame
        frame.size.height = self.view.frame.size.height / 2
        frame.size.width = self.view.frame.size.width / 2
        frame.origin.x = 0
        frame.origin.y = 0
        collectionView.frame = frame

    }
    
    
    
    @IBAction func upBtn_pressed(_ sender: Any) {
        print(userBalance)
        
        userBalance -= 1.0
//        print(currentIndex)
        
     let bucket = buckets[currentIndexPath]
        
        bucket.balance += 1.0
        
        print(bucket.balance)
        
        let per = (bucket.balance / bucket.price) as! Double
        let per2 = Int(per * 100)

        let userbal = Double((userBalance * 100)/100)
        
        
        
        if bucket.balance < 1 {
            
            
            print(per2)
            percentLbl.text = "0%"
            percentLbl.textColor = UIColor.red
//            iconViewimage.backgroundColor = UIColor.red
            
        } else if (per2 < 25) && (per2 > 1) {
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.red
//            iconViewimage.backgroundColor = UIColor.red
//           cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 25) && (per2 < 75) {
            print(per2)
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.black
//            iconViewimage.backgroundColor = UIColor.yellow
//           cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 75) {
            print(per2)
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.green
            
//            iconViewimage.backgroundColor = UIColor.green
            
        }
        
        let buckRef = bucket.ref
        
        buckRef?.child("balance").setValue(bucket.balance)
        
        userBalance -= 1.0
        
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").setValue(userBalance)

        
        
        balaceLbl.text = "$ " + String(bucket.balance) + " of " + "$ " + String(bucket.price)
        

        
        collectionView.reloadData()
    }

    
    @IBAction func downBtn_pressed(_ sender: Any) {
        
        
    }
    

    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buckets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! customCell
        
        cell.layer.cornerRadius = 12
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.white.cgColor
        
        let a = buckets[indexPath.row]
        
        print("INDEX PATH")
        print(indexPath)
        
        cell.itemLbl.text = a.item

       
        cell.iconImageView.image = UIImage(named: "bucket-1")
        
        let per = (a.balance / a.price) as! Double
        let per2 = Int(per * 100)
        
        if a.balance < 1 {
            
            
            
            cell.percentlabel.text = "0%"
            cell.percentlabel.textColor = UIColor.red
            
        } else if (per2 < 25) && (per2 > 1) {
            cell.percentlabel.text = String(per2) + "%"
            cell.percentlabel.textColor = UIColor.red
//           cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 25) && (per2 < 75) {
           
            cell.percentlabel.text = String(per2) + "%"
            cell.percentlabel.textColor = UIColor.yellow
//            cell.iconImageView.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
//            cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 75) {
           
            cell.percentlabel.text = String(per2) + "%"
           cell.percentlabel.textColor = UIColor.green
//            cell.iconImageView.backgroundColor = UIColor.green.withAlphaComponent(0.4)
           
        }
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! customCell
        
        print(indexPath)
        print(indexPath.section)
        print(indexPath.row)
        
        currentIndexPath = indexPath.row
        
       let buck = buckets[indexPath.row]
        self.showBucket(bucket: buck, index: indexPath)
  
//        currentBucket = buckets[indexPath.row]
    }

    
    func showBucket(bucket: Bucket, index: IndexPath) {
        
        print(index)
        
        let url = URL(string: bucket.imageString)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: data!)!
            
            itemImage.image = image
        }
        
        let cell = self.collectionView.cellForItem(at: index)
        
        iconView.center.x = (cell?.center.x)!
        iconView.center.y = (cell?.center.y)!

        
        let per = (bucket.balance / bucket.price) as! Double
        let per2 = Int(per * 100)
        
        balaceLbl.text = "$ " + String(bucket.balance) + " of " + "$ " + String(bucket.price)
        
        
        if bucket.balance < 1 {
            
            
            print(per2)
            percentLbl.text = "0%"
            percentLbl.textColor = UIColor.red
//            iconViewimage.backgroundColor = UIColor.red
            
        } else if (per2 < 25) && (per2 > 1) {
            percentLbl.text = "$" + String(per2) + "%"
            percentLbl.textColor = UIColor.red
//            iconViewimage.backgroundColor = UIColor.red
            //           cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 25) && (per2 < 75) {
            print(per2)
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.yellow
//            iconViewimage.backgroundColor = UIColor.yellow
            //            cell.percentlabel.text = "$" + String(bucket!.balance) + "0"
        } else if (per2 > 75) {
            print(per2)
            percentLbl.text = String(per2) + "%"
            percentLbl.textColor = UIColor.red

//            iconViewimage.backgroundColor = UIColor.green
            
        }


    iconView.bringSubview(toFront: view)
        
        iconView.center.x = view.center.x
          iconView.center.y = view.center.y
        
        
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
