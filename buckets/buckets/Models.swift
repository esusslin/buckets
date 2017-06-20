//
//  Models.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import Foundation

var myBuckets = [Bucket]()
var myProposals = [Proposal]()
//Double(round(1000*x)/1000)

internal class Proposal {
    var item: String
    var price: Double
    var monthly: Double
    var months: Int
    
    let imageString: String
    
    init(item: String, price: Double, imageString: String) {
        self.item = item
        self.price = price
        self.monthly = Double(round(100*(price / 8))/100)
        self.months = 8
        self.imageString = imageString
        
        
    }
}

internal class Bucket {
    var item: String
    var price: Double
    var monthly: Double
    var months: Int
    
    let imageString: String
    
    init(item: String, price: Double, imageString: String, months: Int, monthly: Double) {
        self.item = item
        self.price = price
        self.monthly = monthly
        self.months = months
        self.imageString = imageString
        
        
    }
}
