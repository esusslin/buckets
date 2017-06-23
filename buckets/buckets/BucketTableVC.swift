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
    
    var ref: DatabaseReference!
    
    let balanceView = UIView()
    
    var proposals: [Proposal] = []
    
    var buckets: [Bucket] = []
    
    let section = ["Buckets", "Queue"]


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = false
        
        ref = Database.database().reference()
        print("SELF")
        
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
    
    func addBalanceSubview() {
        
//        let balanceView = UIView(coder: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: self.view.frame.height / 8))
    
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
                self.proposals.append(prop)
            }

            self.tableView.reloadData()
        })
        
//        print(itemsRef)
        self.ref.child("users").child(userID!).child("buckets").observe(.value, with: { snapshot in
            // 2
            
            
            // 3
            for item in snapshot.children {
                // 4
                let prop = Bucket(snapshot: item as! DataSnapshot)
                self.buckets.append(prop)
            }
            
            self.tableView.reloadData()
        })

        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        reloadArrays()
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let dunzo = buckets[indexPath.row]
            dunzo.ref?.removeValue()
        }
        
        if indexPath.section == 1 {
            let dunzo = proposals[indexPath.row]
            dunzo.ref?.removeValue()
            
        }

    
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//   <#code#>
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell
        
        if indexPath.section == 0 {
            print("loading buckets..")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigBucketCell", for: indexPath) as! BigBucketCell
            
            cell.bucket = buckets[indexPath.row]
            
            cell.bindData(bucket: cell.bucket!)
           return cell
        } else {
            
//        }
//        
//        if indexPath.section == 1 {
            print("loading props..")
            let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell
            
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


//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell
//        
//        // Configure the cell...
//        print("loading cells..")
//        
//        cell.itemLbl.text = self.items[indexPath.section][indexPath.row]
//        
//        
//        return cell
//    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
