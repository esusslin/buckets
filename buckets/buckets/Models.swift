//
//  Models.swift
//  buckets
//
//  Created by Emmet Susslin on 6/20/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import Foundation
import Firebase


var username: String?


var myBuckets = [Bucket]()
var myProposals = [Proposal]()
//Double(round(1000*x)/1000)

var userBalance = Double()

var userBal = Double()


//var userBalance = Float()


internal class Channel {
    internal let id: String
    internal let name: String
       
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

struct User {
    
    let id: String
    let name: String
}


//}

internal class Proposal {
    var key: String
    var item: String
    var price: Double
//    var period: String
//    var rate: Double
    var monthly: Double
    var months: Int
    var balance: Double
    var imageString: String
    var active: Bool
    var ref: DatabaseReference?
    
    
    init(item: String, price: Double, key: String = "", user: String) {
        self.key = key
        self.item = item
        self.price = price
        self.monthly = 0.0
        self.months = 0
        self.imageString = ""
        self.balance = 0.0
//        self.period = "monthly"
//        self.rate = 0.0
    
        self.active = false
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        item = snapshotValue["item"] as! String
        price = snapshotValue["price"] as! Double
        monthly = snapshotValue["monthly"] as! Double
        months = snapshotValue["months"] as! Int
        balance = snapshotValue["balance"] as! Double
        active = snapshotValue["active"] as! Bool
        imageString = snapshotValue["imageString"] as! String
//        rate = snapshotValue["rate"] as! Double
//        period = snapshotValue["period"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "item": item,
            "active:": active
        ]
    }
}

internal class Bucket {
    var key: String
    var item: String
    var price: Double
        var period: String
        var rate: Double
    var monthly: Double
    var months: Int
    var balance: Double
    var imageString: String
    var active: Bool
    var ref: DatabaseReference?
    
    
    init(item: String, price: Double, key: String = "", user: String) {
        self.key = key
        self.item = item
        self.price = price
        self.monthly = 0.0
        self.months = 0
        self.imageString = ""
        self.balance = 0.0
        self.period = "monthly"
        self.rate = 0.0
        
        self.active = false
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        item = snapshotValue["item"] as! String
        price = snapshotValue["price"] as! Double
        monthly = snapshotValue["monthly"] as! Double
        months = snapshotValue["months"] as! Int
        balance = snapshotValue["balance"] as! Double
        active = snapshotValue["active"] as! Bool
        imageString = snapshotValue["imageString"] as! String
        rate = snapshotValue["rate"] as! Double
        period = snapshotValue["period"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "item": item,
            "active:": active
        ]
    }
}



//import Foundation
//
//struct GroceryItem {
//    
//    let key: String
//    let name: String
//    let addedByUser: String
//    let ref: DatabaseReference?
//    var completed: Bool
//    
//    init(name: String, addedByUser: String, completed: Bool, key: String = "") {
//        self.key = key
//        self.name = name
//        self.addedByUser = addedByUser
//        self.completed = completed
//        self.ref = nil
//    }
//    
//    init(snapshot: DataSnapshot) {
//        key = snapshot.key
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        name = snapshotValue["name"] as! String
//        addedByUser = snapshotValue["addedByUser"] as! String
//        completed = snapshotValue["completed"] as! Bool
//        ref = snapshot.ref
//    }
//    
//    func toAnyObject() -> Any {
//        return [
//            "name": name,
//            "addedByUser": addedByUser,
//            "completed": completed
//        ]
//    }
//    
//}
