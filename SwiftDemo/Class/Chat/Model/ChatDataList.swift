//
//  ChatDataList.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import RealmSwift

class ChatDataList: Object {
    
    @objc dynamic var userName: String?
    var chatDatasArray = List<ChatModel>()
    
    override static func primaryKey() -> String? {
        return "userName"
    }

}
