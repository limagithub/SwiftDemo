//
//  ChatPeerModel.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ChatPeerModel: NSObject, NSCoding {

    var avatarName: String! = "logoA"
    var peer: MCPeerID!
    var recentMessage: String = ""
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(avatarName, forKey: "avatarName")
        aCoder.encode(peer, forKey: "peer")
        aCoder.encode(recentMessage, forKey: "recentMessage")
    }
    
    required init?(coder aDecoder: NSCoder) {
        avatarName = aDecoder.decodeObject(forKey: "avatarName") as? String
        peer = aDecoder.decodeObject(forKey: "peer") as? MCPeerID
        recentMessage = aDecoder.decodeObject(forKey: "recentMessage") as! String
        
    }
    
    override init() {
        super.init()
    }
}
