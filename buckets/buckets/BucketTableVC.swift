//
//  BucketTableVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/21/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Firebase


class BucketTableVC: UITableViewController {
    
    var proposals: [Proposal] = []
    
    var buckets: [Bucket] = []
    
//    var userBal = Double()
    
    var ref: DatabaseReference!
    

    let section = ["Buckets", "Queue"]


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
            self.tableView.reloadData()
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
            self.tableView.reloadData()
        })
        
        let balanceRef = self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance")
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").observe(.value, with: { snapshot in
        
//        balanceRef.observe(.value, with: { snapshot in
            
            print("balance observing")
            print(snapshot.value!)
            
            userBal = snapshot.value! as! Double
            userBalance = snapshot.value! as! Double
            
            self.title = "$" + String(userBal)
         
//            for child in snapshot.children {   //in case there are several skillets
//                
//                print("child?")
//                print(child)
//                
//                                let key = (child as AnyObject).key as String
//                
//                                let value2 = snapshot.value as! [String : AnyObject]
//              
//                
//                //                print(child[key])
//                                userBal = value2[key]! as! Double
//                                userBalance = value2[key]! as! Double
         
//                            }
//            self.title = "$" + String(userBal)
            print(userBal)
            print(userBalance)
            
        })
      
        
        tableView.allowsMultipleSelectionDuringEditing = false
        

    }
    
    
    @IBAction func days_Action(_ sender: Any) {
        
        
        for b in buckets {
        
            if b.
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
    
    override func viewDidAppear(_ animated: Bool) {
     
        print("APPEAR")
        print(userBal)
//        print(userBalance)
print(userBal)
        let userbal = Double((userBalance * 100)/100)
        

//        self.balance = userbal
//        self.title = "Current Balance:  " + String(balance)
       
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 20)
        header.textLabel?.textColor = UIColor.lightGray
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        
    }
    
//    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font = UIFont(name: "Futura", size: 11)
//        header.textLabel?.textColor = UIColor.lightGrayColor()
//    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 80
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if indexPath.section == 0 {
                let bucket = buckets[indexPath.row]

                userBalance += bucket.balance
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("balance").setValue(userBalance)
                
                bucket.ref?.removeValue()
            }
            
            if indexPath.section == 1 {
                let proposal = proposals[indexPath.row]
                proposal.ref?.removeValue()
            }

        }
    }
    
    
//    func tableView(tableView: UITableView, ViewForHeaderInSection section: Int) -> UIView? {
//        return self.tableView.backgroundColor = UIColor.black
//    }


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
        
        
//        self.balance = userbal
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            

        }
        
        if indexPath.section == 1 {
            let proposal = proposals[indexPath.row]
            
            performSegue(withIdentifier: "proposalShow", sender: indexPath)
        }
       
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

//






