//
//  collectVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/28/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class collectVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     var order = Array(0..<50)

    var longPressGesture : UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "TestCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
        
//        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        self.collectionView?.addGestureRecognizer(longPressGesture)
        
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        print("EHELLLO")
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return order.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! TestCell
        tCell.orderLabel.text = "\(order[indexPath.row])"
        return tCell
    }
    
    func collectionView(collectionView: UICollectionView,
                        moveItemAtIndexPath sourceIndexPath: NSIndexPath,
                        toIndexPath destinationIndexPath: NSIndexPath) {
        
        
        let item = self.order[sourceIndexPath.item]
        self.order.remove(at: sourceIndexPath.item)
        self.order.insert(item, at: destinationIndexPath.item)
    }
}
