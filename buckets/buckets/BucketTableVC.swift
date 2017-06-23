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
    
    var userBalance:Float = 987.94 {
        willSet(newValue){
            self.title = String(userBalance)
        }
        didSet{
            self.title = String(userBalance)
        }
    }

    
    var ref: DatabaseReference!
    
    let balanceView = UIView()
    

    
    let section = ["Buckets", "Queue"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        userBalance = 987.94
         self.title = String(userBalance)
        tableView.allowsMultipleSelectionDuringEditing = false
        
        ref = Database.database().reference()
        print("SELF")
        reloadArrays()
        let tableWidth = view.frame.size.width
        let tableHeight = view.frame.size.height
        
        
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
    
    func reloadArrays() {
        
       proposals.removeAll()
        buckets.removeAll()
        
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
        reloadArrays()
//         self.tableView.reloadData()
//        DispatchQueue.main.async{
//            self.tableView.reloadData()
//        }

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if indexPath.section == 0 {
//            
//            let bucket = buckets[indexPath.row]
//            
//            performSegue(withIdentifier: "bucketShow", sender: indexPath)
//        }
        
        if indexPath.section == 1 {
            let proposal = proposals[indexPath.row]
            
            performSegue(withIdentifier: "proposalShow", sender: indexPath)
        }
       
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        
//    if editingStyle == .delete {
//        if indexPath.section == 0 {
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            let dunzo = buckets[indexPath.row]
//            dunzo.ref?.removeValue()
//
//        }
//        
//        if indexPath.section == 1 {
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            let dunzo = proposals[indexPath.row]
//            dunzo.ref?.removeValue()
//
//        }
//        }
//
//    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell
        
        if indexPath.section == 0 {
            print("loading buckets..")
            
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigBucketCell", for: indexPath) as! BigBucketCell
         cell.viewController = self
            cell.bucket = buckets[indexPath.row]
            
            cell.bindData(bucket: cell.bucket!)
           return cell
        } else {
            
//        }
//        
//        if indexPath.section == 1 {
            print("loading props..")
            let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell
//           cell.viewController = self
            cell.prop = proposals[indexPath.row]
            
            cell.bindData(prop: cell.prop!)
            
            return cell
        }

        
//           let string = buckets[indexPath.row].imageString as! String
            
           
        
        

        
    }
    
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
            let indexPath = sender as! NSIndexPath
            
            if let nav = segue.destination as? UINavigationController {
                let bucketVC = nav.topViewController as? bucketVC!
                let theBucket = buckets[indexPath.row] as! Bucket
                bucketVC?.bucket = theBucket
            }

    }
    

    }



}








