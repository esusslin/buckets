//
//  BucketTableVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/21/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Firebase

class StaticLinker
{
    static var viewController : UITableViewController? = nil
}


class BucketTableVC: UITableViewController {
    
    
    
    var balance: Double = 0.0 {
        willSet(newValue){
            self.title = String(balance)
        }
        didSet{
            self.title = String(balance)
        }
    }

    
    var ref: DatabaseReference!
    
    

    
    let section = ["Buckets", "Queue"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        userBalance = 957.06
        let userbal = Double((userBalance * 100)/100)
       
        
        self.balance = userbal

        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        ref = Database.database().reference()
        print("SELF")
        reloadArrays()
//        let tableWidth = view.frame.size.width
//        let tableHeight = view.frame.size.height
        
        
//        balanceView.frame.size.width = tableWidth / 2
//        balanceView.frame.size.height = tableHeight / 8
//        balanceView.backgroundColor = UIColor.blue
//        balanceView.center.x = view.center.x
//        
//        balanceView.center.y = view.center.y - 300
//        
//        
//        view.addSubview(balanceView)
//        print(view.center.x)
//        print(view.center.y)
//        reloadArrays()
//        tableView.reloadData()
//        addBalanceSubview()
    }
    
    
    @IBAction func days_Action(_ sender: Any) {
        
        let alert = UIAlertController(title: "A Day has now Passed.", message: "Ok?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK, thanks", style: .cancel) { (action) in
            
            
        }
        alert.addAction(cancelAction)
        
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.30)
        alert.view.addConstraint(height);
        self.present(alert, animated: true, completion: nil)

        
        for b in buckets {
            
            let dailly = Double(b.monthly/30)
            let dly = (dailly/100)*100
            
            
             b.balance += dly
        }
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func month_Action(_ sender: Any) {
        
        let alert = UIAlertController(title: "A Whole Month just passed", message: "Ok?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK, thanks", style: .cancel) { (action) in
            
            
        }
        alert.addAction(cancelAction)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.30)
        alert.view.addConstraint(height);
        self.present(alert, animated: true, completion: nil)


        
        for b in buckets {
            
            
            b.balance += b.monthly
        }
        
        self.tableView.reloadData()
        
        
    }
    
    
    
     
    func reloadArrays() {
        
       proposals.removeAll()
        buckets.removeAll()
        
        print("COUNT")
        print(proposals.count)
        print(buckets.count)
        
        let userID = Auth.auth().currentUser?.uid
        


        self.ref.child("users").child(userID!).child("proposals").observe(.value, with: { snapshot in

            for item in snapshot.children {
                // 4
                let prop = Proposal(snapshot: item as! DataSnapshot)
                
                print("KEYS FOR ALLLLLL")
                print(prop.key)
                print(prop.ref)
                proposals.append(prop)
            }
               self.tableView.reloadData()
            
        })

        self.ref.child("users").child(userID!).child("buckets").observe(.value, with: { snapshot in

            for item in snapshot.children {
                // 4
                let prop = Bucket(snapshot: item as! DataSnapshot)
                buckets.append(prop)
            }
            
           self.tableView.reloadData()
        })

        
    }

    
    override func viewDidAppear(_ animated: Bool) {
       
        
        print("APPEAR")
        
        print(userBalance)
//        self.balance = userBalance
        let userbal = Double((userBalance * 100)/100)
        
//       reloadArrays()
        self.balance = userbal
        self.title = "Current Balance:  " + String(balance)
       
//        reloadArrays()
//         self.tableView.reloadData()
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.section [section ]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 80
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return (self.items [section ] as AnyObject).count
        
        if section == 0 {
           return buckets.count
        }
        
        if section == 1 {
            return proposals.count
        }
        return 0
    }
    
    func resetBalance() {
        let userbal = Double((userBalance * 100)/100)
        
        
        self.balance = userbal
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            

        }
        
        if indexPath.section == 1 {
            let proposal = proposals[indexPath.row]
            
            performSegue(withIdentifier: "proposalShow", sender: indexPath)
        }
       
    }

    
    func balanceUpTap(_ sender: UIGestureRecognizer){
        
        print("Up tap")
    }
    
    func balanceDownTap(_ sender: UIGestureRecognizer){
        
        print("Down tap")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell
        
        if indexPath.section == 0 {
            print("loading buckets..")
            
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigBucketCell", for: indexPath) as! BigBucketCell
            cell.viewController = self
         cell.bucket = buckets[indexPath.row]
            cell.bindData(bucket: cell.bucket!)
            cell.bucketDetailBtn.tag = indexPath.row

           return cell
            
        } else {
            

            print("loading props..")
            let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell

            cell.prop = proposals[indexPath.row]
            
            cell.bindData(prop: cell.prop!)
            
            return cell
        }

        
        
    }
    
    func balanceDownTap() {
//        print("LOLLLLLER")
    }
    
//    func bucketSeg(bucket: Bucket) {
//        let bucket = bucket
//        bucketVC?.bucket = theBucket
//        performSegue(withIdentifier: "bucketShow", sender: indexPath)
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "proposalShow" {
            let indexPath = sender as! NSIndexPath
            
            if let nav = segue.destination as? UINavigationController {
                let proposalVC = nav.topViewController as? proposalVC!
                let theProposal = proposals[indexPath.row] as! Proposal
                proposalVC?.proposal = theProposal
            }

        }
        
        if segue.identifier == "bucketShow" {
//            let indexPath = sender as! NSIndexPath
            print(sender)
            
            if let nav = segue.destination as? UINavigationController {
                let bucketVC = nav.topViewController as? bucketVC!
                let theBucket = buckets[(sender! as AnyObject).tag] as! Bucket
                bucketVC?.bucket = theBucket
            }

    }


    }



}








