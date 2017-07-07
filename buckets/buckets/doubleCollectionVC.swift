//
//  doubleCollectionVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/29/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Firebase

class DataItem : Equatable {
    
    var indexes : String = ""
    var colour : UIColor = UIColor.clear
    init(indexes : String, colour : UIColor) {
        self.indexes = indexes
        self.colour = colour
    }
}


func ==(lhs: DataItem, rhs: DataItem) -> Bool {
    return lhs.indexes == rhs.indexes && lhs.colour == rhs.colour
}


class doubleCollectionVC: UIViewController, KDDragAndDropCollectionViewDataSource {
    
    var proposals: [Proposal] = []
    
    var buckets: [Bucket] = []
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var activeCollectionView: UICollectionView!

    @IBOutlet weak var inActiveCollectionView: UICollectionView!
    
    var data : [[DataItem]] = [[DataItem]]()
    
//    var data : [[Any]] = [[Any]]()
    
    var dragAndDropManager : KDDragAndDropManager?

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


        let colours : [UIColor] = [
            UIColor(red: 53.0/255.0, green: 102.0/255.0, blue: 149.0/255.0, alpha: 1.0),
            UIColor(red: 177.0/255.0, green: 88.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        ]
        
        for i in 0...1  {
            
            var items = [DataItem]()
            
            for j in 0...6 {
                
                
                let dataItem = DataItem(indexes: String(i) + ":" + String(j), colour: colours[i])
                
                items.append(dataItem)
                
            }
            
            data.append(items)
             print(data.count)
        }
        
        
        self.dragAndDropManager = KDDragAndDropManager(canvas: self.view, collectionViews: [activeCollectionView, inActiveCollectionView])

//        self.activeCollectionView.reloadData()
//            self.inActiveCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }

    // MARK : UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if section == 0 {
//            
//            print("BUCKETS COUNT")
//            print(buckets.count)
//            return buckets.count
//        }
//        
//        if section == 1 {
//            
//            print("PROPS COUNT")
//            
//            print(proposals.count)
//            return proposals.count
//        }
//        return 0

        
        return data[collectionView.tag].count
    }
    
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(indexPath)
         print(indexPath.section)
           print(indexPath.row)
        
        print(data.count)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! customCell
        
        let dataItem = data[collectionView.tag][indexPath.item]
        
        cell.itemLbl.text = String(indexPath.item) + "\n\n" + dataItem.indexes
        cell.backgroundColor = dataItem.colour
        
        cell.isHidden = false
        
        if let kdCollectionView = collectionView as? KDDragAndDropCollectionView {
            
            if let draggingPathOfCellBeingDragged = kdCollectionView.draggingPathOfCellBeingDragged {
                
                if draggingPathOfCellBeingDragged.item == indexPath.item {
                    
                    cell.isHidden = true
                    
                }
            }
        }
        
        return cell
    }
    
    // MARK : KDDragAndDropCollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, dataItemForIndexPath indexPath: IndexPath) -> AnyObject {
        return data[collectionView.tag][indexPath.item]
    }
    func collectionView(_ collectionView: UICollectionView, insertDataItem dataItem : AnyObject, atIndexPath indexPath: IndexPath) -> Void {
        
        if let di = dataItem as? DataItem {
            data[collectionView.tag].insert(di, at: indexPath.item)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, deleteDataItemAtIndexPath indexPath : IndexPath) -> Void {
        data[collectionView.tag].remove(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveDataItemFromIndexPath from: IndexPath, toIndexPath to : IndexPath) -> Void {
        
        let fromDataItem: DataItem = data[collectionView.tag][from.item]
        data[collectionView.tag].remove(at: from.item)
        data[collectionView.tag].insert(fromDataItem, at: to.item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, indexPathForDataItem dataItem: AnyObject) -> IndexPath? {
        
        if let candidate : DataItem = dataItem as? DataItem {
            
            for item : DataItem in data[collectionView.tag] {
                if candidate  == item {
                    
                    let position = data[collectionView.tag].index(of: item)! // ! if we are inside the condition we are guaranteed a position
                    let indexPath = IndexPath(item: position, section: 0)
                    return indexPath
                }
            }
        }
        
        return nil
        
    }
    


}
