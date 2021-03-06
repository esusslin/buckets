
//  ChannelListTableVC.swift
//  Bucket1
//
//  Created by Emmet Susslin on 6/5/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.


import UIKit
import Firebase

enum Section: Int {
    case createNewChannelSection = 0
    case currentChannelsSection
}


class ChannelListTableVC: UITableViewController {
    
    var ref: DatabaseReference!
    
    var senderDisplayName: String? // 1
    var newChannelTextField: UITextField? // 2
    private var channels: [Channel] = []
    
    private var myChannels: [Channel] = []
    
    private lazy var channelRef: DatabaseReference = Database.database().reference().child("channels")
    private var channelRefHandle: DatabaseHandle?
    
    // MARK: Firebase related methods
    private func observeChannels() {
        
      
        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in // 1
            let channelData = snapshot.value as! Dictionary<String, AnyObject> // 2
            let id = snapshot.key
            
            
            if let name = channelData["name"] as! String!, name.characters.count > 0 { // 3
                self.channels.append(Channel(id: id, name: name))
                self.tableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
    }

//    private func observeMyChannels() {
//        
//        
//        //MARK: Load Recents from firebase
//        
//        ref.child("channels").queryOrdered(byChild: "user1").queryEqual(toValue: "Emmet").observe(.value, with: { (snapshot) in
//            
//            let channelData = snapshot.value as! Dictionary<String, AnyObject> // 2
//            let id = snapshot.key
//            print("WTF")
////            print(snapshot.first)
////            print(snapshot.first)
//            
//            
//
//            
//            if let name = channelData["name"] as! String!, name.characters.count > 0 { // 3
//                self.myChannels.append(Channel(id: id, name: name, user1: channelData["user1"] as! String))
//                
//              //                self.tableView.reloadData()
//            } else {
//                print("Error! Could not decode channel data")
//            }
//            print(self.myChannels.count)
//            print(self.myChannels.first)
//
//        })
////
////
//    }

    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        
        senderDisplayName = "Gary"
        
        ref = Database.database().reference()
        super.viewDidLoad()
        title = "Channels"
        observeChannels()
//        observeMyChannels()
    }
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentSection: Section = Section(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelsSection:
                return channels.count
            }
        } else {
            return 0
        }
    }

    // 3
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if (indexPath as NSIndexPath).section == Section.currentChannelsSection.rawValue {
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Section.currentChannelsSection.rawValue {
            let channel = channels[(indexPath as NSIndexPath).row]
            self.performSegue(withIdentifier: "ShowChannel", sender: channel)
        }
    }
    
   
    @IBAction func createChannel(_ sender: Any) {
        
        if Auth.auth().currentUser?.email == "e@e.com" {
            username = "Emmet"
        }
        
        if Auth.auth().currentUser?.email == "a@a.com" {
            username = "Adrian"
        }


        
        if let name = newChannelTextField?.text { // 1
            let newChannelRef = channelRef.childByAutoId() // 2
            let channelItem = [ // 3
                "name": name,
                "user1": username,
                "user2": "BFF"
            ]
            newChannelRef.setValue(channelItem) // 4
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            let chatVc = segue.destination as! ChatVC
            
            if Auth.auth().currentUser?.email == "e@e.com" {
                username = "Emmet"
            }
            
            if Auth.auth().currentUser?.email == "a@a.com" {
                username = "Adrian"
            }

            
            chatVc.senderDisplayName = "Gary"
            chatVc.channel = channel
            chatVc.channelRef = channelRef.child(channel.id)
        }
    }
    
    @IBAction func backBtn_pressed(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
    
}
