//
//  ChatVC.swift
//  Bucket1
//
//  Created by Emmet Susslin on 6/5/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

//import UIKit
//import Firebase
//import JSQMessagesViewController
//import Photos
//import ActionCableClient
////import Starscream
//import SwiftWebSocket
//
//
//
//
//
//
//final class ChatVC: JSQMessagesViewController {
//    
////    var socket = WebSocket(url: URL(string: "wss://salty-meadow-12931.herokuapp.com/cable")!)
////    
////    let user1 = User(id: "1", name: "Steve")
////    let user2 = User(id: "2", name: "Tim")
//    
//    
//    var currentUser: User {
//        return user1
//    }
//    
//    
//            // ELEMENTS:
//            var messages = [JSQMessage]()
//    
//    
//            var channelRef: DatabaseReference?
//            var channel: Channel? {
//                didSet {
//                    title = channel?.name
//                }
//            }
//
//            private lazy var messageRef: DatabaseReference = self.channelRef!.child("messages")
//            private var newMessageRefHandle: DatabaseHandle?
//    
//            private lazy var usersTypingQuery: DatabaseQuery = self.channelRef!.child("typingIndicator").queryOrderedByValue().queryEqual(toValue: true)
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//
//        
////        actionClient.onDisconnected = {(error: Error?) in
////            print("Disconnected!")
////        }
//        
//        
//        self.tabBarController?.tabBar.isHidden = true
//        
//        observeMessages()
//        
//        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
//        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
//        
//        self.senderId = Auth.auth().currentUser?.uid
//    }
//    
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        observeTyping()
//    }
//    
//    
//    
//        
//    
//    
//    
//    // CREATES A NEW MESSAGE
//            override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
//                let itemRef = messageRef.childByAutoId() // 1
//                let messageItem = [ // 2
//                    "senderId": senderId!,
//                    "senderName": senderDisplayName!,
//                    "text": text!,
//                    ]
//                
//                isTyping = false
//                
//                itemRef.setValue(messageItem) // 3
//                
//                JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
//                
//                finishSendingMessage() // 5
//            }
//    
//    
//    // APPENDS MESSAGE TO COLLECTIONVIEW
//            private func addMessage(withId id: String, name: String, text: String) {
//                if let message = JSQMessage(senderId: id, displayName: name, text: text) {
//                    messages.append(message)
//                }
//            }
//
//    
//    // QUERIES AND DISPLAYS MESSAGES
//            private func observeMessages() {
//                messageRef = channelRef!.child("messages")
//                // 1.
//                let messageQuery = messageRef.queryLimited(toLast:25)
//                
//                // 2. We can use the observe method to listen for new
//                // messages being written to the Firebase DB
//                newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
//                    // 3
//                    let messageData = snapshot.value as! Dictionary<String, String>
//                    
//                    if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
//                        // 4
//                        self.addMessage(withId: id, name: name, text: text)
//                        
//                        // 5
//                        self.finishReceivingMessage()
//                    } else {
//                        print("Error! Could not decode message data")
//                    }
//                })
//            }
//    
//    
//    // 3 DOTS WHILE TYPING
//            override func textViewDidChange(_ textView: UITextView) {
//                super.textViewDidChange(textView)
//                // If the text is not empty, the user is typing
//                isTyping = textView.text != ""
//            }
//            
//            private lazy var userIsTypingRef: DatabaseReference =
//                self.channelRef!.child("typingIndicator").child(self.senderId) // 1
//            private var localTyping = false // 2
//            var isTyping: Bool {
//                get {
//                    return localTyping
//                }
//                set {
//                    // 3
//                    localTyping = newValue
//                    userIsTypingRef.setValue(newValue)
//                }
//            }
//            
//            private func observeTyping() {
//                let typingIndicatorRef = channelRef!.child("typingIndicator")
//                userIsTypingRef = typingIndicatorRef.child(senderId)
//                userIsTypingRef.onDisconnectRemoveValue()
//                
//                    // 1
//                    usersTypingQuery.observe(.value) { (data: DataSnapshot) in
//                        // 2 You're the only one typing, don't show the indicator
//                        if data.childrenCount == 1 && self.isTyping {
//                            return
//                        }
//                    }
//                
//                    // 1
//                    usersTypingQuery.observe(.value) { (data: DataSnapshot) in
//                        // 2 You're the only one typing, don't show the indicator
//                        if data.childrenCount == 1 && self.isTyping {
//                            return
//                        }
//                    }
//                    
//            }
//
//    
//     
//    
//    
//    
//    
//    // CHAT FUNCTIONS:
//    
//    
//    // MARK: Collection view data source (and related) methods
//            override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
//                return messages[indexPath.item]
//            }
//            
//            override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//                return messages.count
//            }
//            
//            private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
//                let bubbleImageFactory = JSQMessagesBubbleImageFactory()
//                return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
//            }
//            
//            private func setupIncomingBubble() -> JSQMessagesBubbleImage {
//                let bubbleImageFactory = JSQMessagesBubbleImageFactory()
//                return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
//            }
//            
//            lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
//            lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
//            
//            
//            
//            override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
//                let message = messages[indexPath.item] // 1
//                if message.senderId == senderId { // 2
//                    return outgoingBubbleImageView
//                } else { // 3
//                    return incomingBubbleImageView
//                }
//            }
//            
//            override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//                let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
//                let message = messages[indexPath.item]
//                
//                if message.senderId == senderId {
//                    cell.textView?.textColor = UIColor.white
//                } else {
//                    cell.textView?.textColor = UIColor.black
//                }
//                return cell
//            }
//            
//            
//            override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
//                return nil
//            }
//    
//    
//    // MARK: Firebase related methods
//    
//    
//    // MARK: UI and User Interaction
//    
//    
//    // MARK: UITextViewDelegate methods
//    
//}
