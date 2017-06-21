//
//  AppDelegate.swift
//  buckets
//
//  Created by Emmet Susslin on 6/19/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import Parse
import Bolts
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization safter application launch.
        
         FirebaseApp.configure()

        
        
        

        
//        let parseConfig = ParseClientConfiguration { (ParseMutableClientConfiguration) in
//            
//            ParseMutableClientConfiguration.applicationId = "buckets1"
//            ParseMutableClientConfiguration.clientKey = "bucketsofrainbucketsoftears"
//            ParseMutableClientConfiguration.server = "http://buckets.herokuapp.com/parse"
//        }
//        
//        Parse.initialize(with: parseConfig)
//        
//        setupParse()
        
        return true
    }
    
    
//    
//    private func setupParse() {
//        
    
            
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackground { (success: Bool, error: Error?) in
//            if let error = error {
//                print(#line, error)
//            }
//            guard success else {
//                print(#line, "object not saved, WTF!")
//                return
//            }
//            
//            print("Object has been saved!")#12	0x0000000102cbbe17 in main at /Users/emmet/Desktop/buckets/buckets/buckets/AppDelegate.swift:15

//        }
//    }

  
}

