//
//  proposalVC.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class proposalVC: UIViewController {
    
    var proposal: Proposal?
    
    @IBOutlet weak var itemLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

            itemLbl.text = proposal?.item
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func BackBtn_pressed(_ sender: Any) {
         dismiss(animated: true)
    }
    

}
