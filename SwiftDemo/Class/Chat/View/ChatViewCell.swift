//
//  ChatViewFrame.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit

// 昵称的字体
let kMyTimeFont = UIFont.systemFont(ofSize: 13.0)
// 正文的字体
let kMyTextFont = UIFont.systemFont(ofSize: 14.0)

let kMyInset: CGFloat = 20.0

extension UIImage {
    class func resizableImageWithName(_ name: String) -> UIImage {
        let normal = UIImage(named: name)
        if normal == nil {
            return UIImage()
        }
        let w = normal!.size.width * 0.5
        let h = normal!.size.height * 0.5
        return normal!.resizableImage(withCapInsets: UIEdgeInsets(top: h, left: w, bottom: h, right: w))
        
    }
}

class ChatViewCell: UITableViewCell {

    weak var timeLabel: UILabel?
    weak var iconImageView: UIImageView?
    weak var textBtn: UIButton?
    private var chatFrame: ChatViewFrame?
    var chatViewFrame: ChatViewFrame? {
        get {
            return chatFrame
        }
        set(newChatViewFrame) {
            if newChatViewFrame != nil {
                //1.获取数据模型
                chatFrame = newChatViewFrame
                let chatData = newChatViewFrame!.chatData
              
                //2.设置各个控件的的数据
                self.settingViewWithData(chatData)
                
                //3.设置各个控件的的Frame
                self.settingFrameWithData(chatData)
            }
            
        }
    }
    
    /**
     *  重写init方法来添加控件
     */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //1.添加聊天时间控件
        
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.tintColor = UIColor.gray
        label.font = kMyTimeFont
        self.contentView.addSubview(label)
        self.timeLabel = label

        //2.添加聊天头像
        let image = UIImageView()
        self.contentView.addSubview(image)
        self.iconImageView = image

        //3.添加聊天内容
        let textBtn = UIButton()
        textBtn.titleLabel!.numberOfLines = 0
        textBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        textBtn.titleLabel!.font = kMyTextFont
        textBtn.contentEdgeInsets = UIEdgeInsets(top: kMyInset, left: kMyInset, bottom: kMyInset, right: kMyInset)
        self.contentView.addSubview(textBtn)
        self.textBtn = textBtn

        //4.去除cell的背景色，tableView的背景色才能生效
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open class func chatViewCellWithTableView(tableView: UITableView) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "ChatViewCell")
        if cell == nil {
            cell = ChatViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ChatViewCell")
        }
        return cell!
    }
    
    /**
     *  设置数据
     */
    func settingViewWithData(_ chatData: ChatModel) {
        //1.时间控件
        self.timeLabel?.text = chatData.time
        
        //2.头像控件
        let iconName = chatData.chatDataByMeFlag.boolValue == true ? "me" : "other"
        self.iconImageView?.image = UIImage(named: iconName)
        
        //3.聊天文本控件
        self.textBtn?.setTitle(chatData.message, for:UIControl.State.normal)
    }
    
    /**
     *  设置Frame
     */
    func settingFrameWithData(_ chatData: ChatModel) {
        //1.时间控件
        self.timeLabel?.frame = (self.chatViewFrame?.timeF)!
        
        //2.头像控件
        self.iconImageView?.frame = (self.chatViewFrame?.iconF)!
        
        //3.聊天文本控件
        self.textBtn?.frame = (self.chatViewFrame?.textF)!
        
        //4.设置聊天文字的背景图片
        if chatData.chatDataByMeFlag.boolValue == true {
            self.textBtn?.setBackgroundImage(UIImage.resizableImageWithName("chat_send_nor"), for: UIControl.State.normal)
            self.textBtn?.setBackgroundImage(UIImage.resizableImageWithName("chat_send_press_pic"), for: UIControl.State.highlighted)
        }else{
            self.textBtn?.setBackgroundImage(UIImage.resizableImageWithName("chat_recive_nor"), for: UIControl.State.normal)
            self.textBtn?.setBackgroundImage(UIImage.resizableImageWithName("chat_recive_press_pic"), for: UIControl.State.highlighted)
        }
        
    }
}
