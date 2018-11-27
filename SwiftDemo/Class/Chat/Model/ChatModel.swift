//
//  ChatModel.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import RealmSwift

enum ChatModelSender : Int {
    case ChatModelSenderMe = 1
    case ChatModelSenderOthers
}

class ChatModel: Object {

    @objc dynamic var message: String?
    @objc dynamic var time: String?
    @objc dynamic var chatDataByMeFlag: NSNumber = NSNumber(value: -1)
}
