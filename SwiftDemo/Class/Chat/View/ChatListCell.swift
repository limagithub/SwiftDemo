//
//  ChatViewFrame.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var onlineStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open class func chatListCellWithTableView() -> ChatListCell {
        
        let chatCell = Bundle.main.loadNibNamed("ChatListCell", owner: nil, options: nil)?.first as! ChatListCell
        chatCell.backgroundView = nil
        chatCell.backgroundColor = UIColor(white: 1, alpha: 0.1)
        chatCell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        chatCell.contentView.backgroundColor = UIColor.clear
        chatCell.iconImageView.layer.cornerRadius = chatCell.iconImageView.bounds.size.height * 0.5
        return chatCell
    }
}
