//
//  ChatViewModel.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import RealmSwift

let peerIDFilePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! + "/peeridchatPeerList.dat"
protocol ChatPeerManagerDelegate {
    
    // 搜索到设备
    func foundPeer(_ peer: MCPeerID)
    // 丢失设备
    func lostPeer(_ peer: MCPeerID)
    // 收到会话邀请
    func invitationWasReceived(fromPeer: MCPeerID)
    // 连接到设备
    func connectedWithPeer(_ peer: MCPeerID)
    // 更新列表
    func reloadData()
}

protocol ChatStoreDataDelegate {
    
    //    // 搜索到设备
    //    func (_ peer: MCPeerID)
    //    // 丢失设备
    //    func lostPeer()
    //    // 收到会话邀请
    //    func invitationWasReceived(fromPeer: MCPeerID)
    //    // 连接到设备
    //    func connectedWithPeer(_ peer: MCPeerID)
    //    // 更新列表
    //    func reloadData()
}


class ChatViewModel: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    
    var newSession: MCSession?
    
    var myPeerSessions = [String: MCSession]()
    var browser: MCNearbyServiceBrowser!
    var advertiser: MCNearbyServiceAdvertiser!
    
    var delegate: ChatPeerManagerDelegate?
    var foundPeers = [String: MCPeerID]()
    
    var invitationHandler: ((Bool, MCSession?) -> Void)!
    
    var currentChattingName: String!
    
    var chatList: ChatDataList?
    
    var onlineStateTextDict = [String: String]()
    
    lazy var chatPeersArray: NSMutableArray = {
        return NSMutableArray()
    }()
    
    override init() {
        super.init()
        
        let currentPeer = MCPeerID(displayName: UIDevice.current.name)
        
        self.newSession = MCSession(peer: currentPeer, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        self.newSession!.delegate = self
        
        self.browser = MCNearbyServiceBrowser(peer: currentPeer, serviceType: "YoChat")
        self.browser.delegate = self
        
        self.advertiser = MCNearbyServiceAdvertiser(peer: currentPeer, discoveryInfo: nil, serviceType: "YoChat")
        self.advertiser.delegate = self
        
        self.browser.startBrowsingForPeers()
        self.advertiser.startAdvertisingPeer()
    }
    
    /**
     *  MCSessionDelegate method
     */
    // 会话的连接状态变化代理
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connecting:
            print("Session is connecting to \(peerID.displayName)")
        case .connected:
            print("Session connected to \(peerID.displayName)")
            self.onlineStateTextDict.updateValue("在线", forKey: peerID.displayName)
            self.delegate?.reloadData()
            self.myPeerSessions[peerID.displayName] = session
            
        case .notConnected:
            print("Session disConnect to \(peerID.displayName)")
            session.disconnect()
            self.myPeerSessions.removeValue(forKey: peerID.displayName)
            self.onlineStateTextDict.updateValue("离线", forKey: peerID.displayName)
            self.delegate?.lostPeer(peerID)
        }
    }
    
    // 收到数据
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("Receive Data:\(data)")
        
        let dictionary: [String: AnyObject] = ["data": data as AnyObject, "fromPeer": peerID]
        //通知界面跟新
//        DispatchQueue.main.async {
//                    self.delegate?.foundPeer(peerID)
//                }
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as! Dictionary<String, AnyObject>
        if let message = dataDictionary["message"] as? String {
            //1.创建一条新的消息模型, 并将此消息存到realm数据库中
            let newChatData = ChatModel()
            newChatData.message = message
            newChatData.chatDataByMeFlag = NSNumber(value: false)
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            newChatData.time = formatter.string(from: Date())
            self.storeChatData(newChatData, with: peerID.displayName)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "receivedMPCDataNotification"), object: dictionary)
    }
    
    func storeChatData(_ data: ChatModel, with userName: String) {
        // 将聊天记录存储到Realm数据库中
        DispatchQueue.main.async {
            self.chatList = self.getChatListFromLocalDataBaseWith(userName: userName)
            let realm = try! Realm()
            //        print("\(realm.configuration.fileURL)")
            try! realm.write {
                self.chatList!.chatDatasArray.append(data)
                realm.add(self.chatList!, update: true)
            }
        }
    }
    
    func deleteChatData(userName: String) {
        //删除聊天记录
         DispatchQueue.main.async {
            let realm = try! Realm()
            self.chatList = self.getChatListFromLocalDataBaseWith(userName: userName)
            try! realm.write {
                realm.delete(self.chatList!)
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) { }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) { }
    
    // 搜索到设备
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        print("找到设备found peer:\(peerID) -------\(info)")
        let chatPeerModel = ChatPeerModel()
        chatPeerModel.peer = peerID
        self.chatPeersArray.add(chatPeerModel)
        NSKeyedArchiver.archiveRootObject(self.chatPeersArray.copy(), toFile: peerIDFilePath)
        self.onlineStateTextDict.updateValue("在线", forKey: peerID.displayName)
        let dictionary: [String: AnyObject] = ["MCPeerId": peerID]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "RadarViewControllerFindObject"), object: dictionary)
        
        
//        DispatchQueue.main.async {
//            self.delegate?.foundPeer(peerID)
//        }
        
//        browser.invitePeer(peerID, to: self.newSession!, withContext: nil, timeout: 20)
        
    }
    // 丢失设备
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        print("丢失设备：\(peerID)")
        let chatPeerModel = ChatPeerModel()
        chatPeerModel.peer = peerID
        self.chatPeersArray.remove(chatPeerModel)
        self.myPeerSessions[peerID.displayName]?.disconnect()
        self.myPeerSessions.removeValue(forKey: peerID.displayName)
        self.onlineStateTextDict.updateValue("离线", forKey: peerID.displayName)
        DispatchQueue.main.async {
            self.delegate?.lostPeer(peerID)
        }
    }
    // 搜索出错
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print(error.localizedDescription)
    }
    
    //MARK:- MCNearbyServiceAdvertiserDelegate method
    // 广播出错
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print(error.localizedDescription)
    }
    
    // 收到会话邀请
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        print("Received Invitation From  \(peerID.displayName)")
        
        invitationHandler(true, self.newSession!)
        
        //        self.delegate?.invitationWasReceived(fromPeer: peerID)
    }
    
    // 发送数据
    func sendData(dictionaryWithData dictionary: Dictionary<String, String>, toPeer targetPeer: MCPeerID) -> Bool {
        let dataToSend = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        let peersArray = NSArray(object: targetPeer)
        
        let session = self.myPeerSessions[targetPeer.displayName]
        guard let _ = try? session?.send(dataToSend, toPeers: peersArray as! [MCPeerID], with: MCSessionSendDataMode.reliable) else{
            print("send data error！")
            return false
        }
        
        return true
    }
    
    func getChatListFromLocalDataBaseWith(userName name: String) -> ChatDataList {
        /**
         *  加载数据库中的文件
         */
        let predicate = NSPredicate(format: "userName == %@", name)
        
        var chatList: ChatDataList? = try! Realm().objects(ChatDataList.self).filter(predicate).first
        if chatList == nil {
            chatList = ChatDataList()
            chatList!.userName = name
        }
        return chatList!
    }
    
    
    
    

}
