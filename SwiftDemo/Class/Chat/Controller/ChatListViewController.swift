//
//  ChatListViewController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

let reuseID = "ChatListCell"
let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! + "/chatPeerList.dat"

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatPeerManagerDelegate{
    
    lazy var tableView: UITableView? = {
        let customTableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        self.view.addSubview(customTableView)
        return customTableView
    }()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var chatPeersArray: Array<ChatPeerModel> = {
        if let chatPeerList = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) {
            return chatPeerList as! [ChatPeerModel]
        }
        return [ChatPeerModel]()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "聊天列表"
        self.appDelegate.chatViewModel.delegate = self
        
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.rowHeight = 70
        self.tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView?.tableHeaderView = nil
        self.tableView?.tableFooterView = nil
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 45/255.0, green: 63/255.0, blue: 84/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        // 修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backgroundImageView = UIImageView.init(frame: view.bounds)
        backgroundImageView.backgroundColor = UIColor(red: 45/255.0, green: 63/255.0, blue: 84/255.0, alpha: 1.0)
        //        backgroundImageView.image = UIImage.init(named: "background.jpg")
        self.tableView?.backgroundView = backgroundImageView
        
        // 开始搜索设备
        //        self.appDelegate.chatViewModel.browser.startBrowsingForPeers()
        
        // 开始广播
        //        self.appDelegate.chatViewModel.vadvertiser.startAdvertisingPeer()
        
        
        // 获取到数据通知
        NotificationCenter.default.addObserver(self, selector: #selector(handleMPCReceivedDataWithNotification), name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)
    }
    
    //MARK: - ChatViewModelDelegate Method
    func foundPeer(_ peer: MCPeerID) {
        for (index, chatPeerModel) in self.chatPeersArray.enumerated() {
            if chatPeerModel.peer.displayName == peer.displayName {
                self.chatPeersArray[index].peer = peer
                //                DispatchQueue.main.async {
                //                    self.tableView?.reloadData()
                //                }
                return
            }
        }
        let chatPeerModel = ChatPeerModel()
        chatPeerModel.peer = peer
        self.chatPeersArray.append(chatPeerModel)
        self.reloadData()
    }
    
    func lostPeer(_ peer: MCPeerID) {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
            if (self.navigationController?.viewControllers.count)! > 1 {
                let chattingVC = self.navigationController?.viewControllers.last as! ChattingViewController
                chattingVC.tableView?.reloadData()
            }
        }
    }
    
    func invitationWasReceived(fromPeer: MCPeerID) {
        
        print("invitation was received!")
        self.appDelegate.chatViewModel.invitationHandler(true, self.appDelegate.chatViewModel.newSession)
    }
    
    func connectedWithPeer(_ peer: MCPeerID) {
        
        let chattingVC = ChattingViewController()
        chattingVC.title = peer.displayName
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(chattingVC, animated: true)
        }
    }
    
    func reloadData() {
        self.storeChatList()
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func storeChatList() {
        NSKeyedArchiver.archiveRootObject(self.chatPeersArray, toFile: filePath)
    }
    
    @objc func handleMPCReceivedDataWithNotification(_ notification: Notification) {
    
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        let data = receivedDataDictionary["data"] as? NSData
        let fromPeer = receivedDataDictionary["fromPeer"] as? MCPeerID
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data! as Data ) as! Dictionary<String, AnyObject>
        
        if let message = dataDictionary["message"] as? String {
            for (_, chatPeerModel) in self.chatPeersArray.enumerated() {
                if chatPeerModel.peer.displayName == fromPeer?.displayName {
                    chatPeerModel.recentMessage = message
                }
            }
            // print("\(self.chatPeersArray[0].recentMessage)")
            self.reloadData()
        }
        
        for (index, chatPeerModel) in self.chatPeersArray.enumerated() {
            if chatPeerModel.peer.displayName == fromPeer?.displayName {
                self.chatPeersArray[index].peer = fromPeer
                //                DispatchQueue.main.async {
                //                    self.tableView?.reloadData()
                //                }
                return
            }
        }
        let chatPeerModel = ChatPeerModel()
        chatPeerModel.peer = fromPeer
        self.chatPeersArray.append(chatPeerModel)
        self.reloadData()
        
        
        
    }
    
    //MARK:- tableview datasource & delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.chatPeersArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ChatListCell.chatListCellWithTableView()
        
        let chatPeerModel = self.chatPeersArray[indexPath.section]
        cell.userNameLabel.text = chatPeerModel.peer.displayName
        cell.iconImageView!.image = UIImage(named: chatPeerModel.avatarName)
        cell.messageLabel.text = chatPeerModel.recentMessage
        if let onlineStateText = self.appDelegate.chatViewModel.onlineStateTextDict[chatPeerModel.peer.displayName] {
            cell.onlineStateLabel.text = onlineStateText
        }else {
            cell.onlineStateLabel.text = "离线"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let chatPeerModel = self.chatPeersArray[indexPath.section]
        let destPeer = chatPeerModel.peer!
        print("\(destPeer)")
        if self.appDelegate.chatViewModel.newSession!.connectedPeers.contains(destPeer) == false {
            self.appDelegate.chatViewModel.browser.invitePeer(destPeer, to: self.appDelegate.chatViewModel.newSession!, withContext: nil, timeout: 10)
        }
        self.appDelegate.chatViewModel.currentChattingName = destPeer.displayName
        self.connectedWithPeer(destPeer)
    }
    
    //开启编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //返回编辑类型，滑动删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             let chatPeerModel = self.chatPeersArray[indexPath.row]
            self.chatPeersArray.remove(at: indexPath.row)
            self.reloadData()
            let destPeer = chatPeerModel.peer!
            self.appDelegate.chatViewModel.deleteChatData(userName: destPeer.displayName)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}
