//
//  BuckTableVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/27/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Firebase

class BuckTableVC: UITableViewController {
    
    var proposals: [Proposal] = []
    
    var buckets: [Bucket] = []
    
    var ref: DatabaseReference!
    
    let section = ["Buckets", "Queue"]
    
    let userID = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
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
        

        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.section [section ]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 80
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return buckets.count
        }
        
        if section == 1 {
            return proposals.count
        }
        return 0

    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        

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
