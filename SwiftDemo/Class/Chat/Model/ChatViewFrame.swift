//
//  ChatViewFrame.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit

class ChatViewFrame: NSObject {
    /**
     *  聊天内容Frame
     */
    var textF: CGRect?
    /**
     *  聊天时间Frame
     */
    var timeF: CGRect?
    /**
     *  头像Frame
     */
    var iconF: CGRect?
    /**
     *  cell高度
     */
    var cellHeight: CGFloat?
    /**
     *  判断标志：是否与上一条聊天数据时间相同
     */
    var isTheSameTime: Bool?
    /**
     *  数据模型
     */
    private var data: ChatModel = ChatModel()
    var chatData: ChatModel {
        get{
            return data
        }
        set(newChatData){
            data = newChatData
            
            let margin: CGFloat = 10
            //1.计算聊天时间控件的frame
            
            if self.isTheSameTime == false {
                let timeW: CGFloat = UIScreen.main.bounds.size.width
                let timeH: CGFloat = 40
                let timeX: CGFloat = 0
                let timeY: CGFloat = margin
                
                self.timeF = CGRect(x: timeX, y: timeY, width: timeW, height: timeH)
            }else {
                self.timeF = CGRect.zero
            }
            
            //2.计算聊天头像控件的frame
            let iconW: CGFloat = 40
            let iconH: CGFloat = iconW
            let iconY: CGFloat = margin + self.timeF!.maxY
            let iconX: CGFloat
            
            if chatData.chatDataByMeFlag.boolValue == true {
                iconX = UIScreen.main.bounds.size.width - margin - iconW
            }else{
                iconX = margin
            }
            
            self.iconF = CGRect(x: iconX, y: iconY, width: iconW, height: iconH)
            
            //3.计算聊天内容控件的frame
            
            let messsage = chatData.message! as NSString
            let textSize = messsage.boundingRect(with: CGSize.init(width: 150, height: Int.max), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: kMyTextFont], context: nil).size
            
            let textW: CGFloat = textSize.width + kMyInset * 2
            let textH: CGFloat = textSize.height + kMyInset * 2
            let textX: CGFloat
            let textY: CGFloat = iconY
            
            if chatData.chatDataByMeFlag.boolValue == true {
                textX = iconX - margin - textW
                
            }else{
                textX = iconX + iconW + margin
            }
            
            self.textF = CGRect(x: textX, y: textY, width: textW, height: textH)
            
            //4.计算cell的高度
            let maxIconY: CGFloat = self.iconF!.maxY
            let maxTextY: CGFloat = self.textF!.maxY
            self.cellHeight = max(maxIconY, maxTextY)
            
        }
    }
}
