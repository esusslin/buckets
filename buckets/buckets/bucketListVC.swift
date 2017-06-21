//
//  bucketListVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class bucketListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let headerTitles = ["Buckets", "Proposals"]
    
    let data = [myBuckets, myProposals] as [Any]
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        print("section0 count!")
        print(myBuckets.count)
        
        print("section1 count!")
        print(myProposals.count)
        
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            print("section0 count!")
            print(myBuckets.count)
            return myBuckets.count
        } else {
            
            print("section1 count!")
            print(myProposals.count)

            return myProposals.count
        }

    }
    
    //MARK: UITableviewDelegate functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! bucketCell
        let bucket = myBuckets[indexPath.row]
        cell.bindBuckets(bucket: bucket)
        return cell
        
      } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as! bucketCell
        let prop = myProposals[indexPath.row]
        cell.bindProposals(proposal: prop)
        return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(indexPath)
        print(indexPath.section)
       
//        if indexPath.section == 0 {
//          performSegue(withIdentifier: "proposalShow", sender: indexPath)
//            
//        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "proposalShow" {
            let indexPath = sender as! NSIndexPath
            
            if let nav = segue.destination as? UINavigationController {
                let proposalVC = nav.topViewController as? proposalVC!
                let theProposal = myProposals[indexPath.row]
                proposalVC?.proposal = theProposal
            }
            
            
            
            
        }
    }





}
