//
//  BucketTableVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/21/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class BucketTableVC: UITableViewController {
    
    let section = ["Buckets", "Queue"]
//    let footer = ["- - - - - - - - - - - - - - -", "- - - - - - - - - - - - - - -"]
//    
//    let items = [myBuckets, myProposals] as [[Any]]
//    let items = [["Margarita", "BBQ Chicken", "Pepperoni"], ["sausage", "meat lovers", "veggie lovers"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
//        print(items)
//        print(items.count)
        print("---------------")
        print(myBuckets)
        print(myBuckets.count)
        print("---------------")
        print(myProposals)
        print(myProposals.count)
        print("---------------")
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
           return myBuckets.count
        }
        
        if section == 1 {
            return myProposals.count
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! BucketCell
        
        print("loading cells..")
        
        if indexPath.section == 0 {
            print("loading buckets..")
            
              cell.itemLbl.text = myBuckets[indexPath.row].item
            
//            if myBuckets.count < 0 {
//                let item = self.items[indexPath.section][indexPath.row] as! Bucket
//                    cell.itemLbl.text = item.item
//                } else {
//                    cell.itemLbl.text = "No Buckets Yet"
//                }

        }
        
        if indexPath.section == 1 {
            print("loading proposals..")
           cell.itemLbl.text = myProposals[indexPath.row].item
        }

        
        
        

        return cell
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
