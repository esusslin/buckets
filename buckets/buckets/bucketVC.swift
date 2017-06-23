//
//  bucketVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/21/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class bucketVC: UIViewController {

    
    var bucket: Bucket?
    
    @IBOutlet weak var itemLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLbl.text = bucket?.item
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true)
    }

}
