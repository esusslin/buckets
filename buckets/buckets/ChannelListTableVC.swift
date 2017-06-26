//
//  ChannelListTableVC.swift
//  Bucket1
//
//  Created by Emmet Susslin on 6/5/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

//import UIKit
//import Firebase
//
//enum Section: Int {
//    case createNewChannelSection = 0
//    case currentChannelsSection
//}
//
//
//class ChannelListTableVC: UITableViewController {
//    
//    var senderDisplayName: String? // 1
//    var newChannelTextField: UITextField? // 2
//    private var channels: [Channel] = []
//    
//    private lazy var channelRef: DatabaseReference = Database.database().reference().child("channels")
//    private var channelRefHandle: DatabaseHandle?
//    
//    // MARK: Firebase related methods
//    private func observeChannels() {
//        
//        // Use the observe method to listen for new
//        // channels being written to the Firebase DB
//        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in // 1
//            let channelData = snapshot.value as! Dictionary<String, AnyObject> // 2
//            let id = snapshot.key
//            if let name = channelData["name"] as! String!, name.characters.count > 0 { // 3
//                self.channels.append(Channel(id: id, name: name))
//                self.tableView.reloadData()
//            } else {
//                print("Error! Could not decode channel data")
//            }
//        })
//    }
//
//    
//    
//    // MARK: View Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Channels"
//        observeChannels()
//    }
//    
//    deinit {
//        if let refHandle = channelRefHandle {
//            channelRef.removeObserver(withHandle: refHandle)
//        }
//    }
//    
//    
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let currentSection: Section = Section(rawValue: section) {
//            switch currentSection {
//            case .createNewChannelSection:
//                return 1
//            case .currentChannelsSection:
//                return channels.count
//            }
//        } else {
//            return 0
//        }
//    }
//
//    // 3
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
//        
//        if (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue {
//            if let createNewChannelCell = cell as? CreateChannelCell {
//                newChannelTextField = createNewChannelCell.newChannelNameField
//            }
//        } else if (indexPath as NSIndexPath).section == Section.currentChannelsSection.rawValue {
//            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
//        }
//        
//        return cell
//    }
//    
//    // MARK: UITableViewDelegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == Section.currentChannelsSection.rawValue {
//            let channel = channels[(indexPath as NSIndexPath).row]
//            self.performSegue(withIdentifier: "ShowChannel", sender: channel)
//        }
//    }
//    
//   
//    @IBAction func createChannel(_ sender: Any) {
//        
//        if let name = newChannelTextField?.text { // 1
//            let newChannelRef = channelRef.childByAutoId() // 2
//            let channelItem = [ // 3
//                "name": name
//            ]
//            newChannelRef.setValue(channelItem) // 4
//        }
//    }
//    
//    // MARK: Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        
//        if let channel = sender as? Channel {
//            let chatVc = segue.destination as! ChatVC
//            
//            chatVc.senderDisplayName = username
//            chatVc.channel = channel
//            chatVc.channelRef = channelRef.child(channel.id)
//        }
//    }
//    
//    
//    
//}
