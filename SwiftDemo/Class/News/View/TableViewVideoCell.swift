//
//  TableViewVideoCell.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/26.
//  Copyright © 2018年 qclong. All rights reserved.
//

import UIKit

class TableViewVideoCell: UITableViewCell {

    
    @IBOutlet weak var titileLabel: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var avatalImage: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var commonLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var aNews = NewsModel() {
        didSet {
            titileLabel.text = aNews.title
            videoImage.sd_setImage(with: URL.init(string: (aNews.video_detail_info.detail_video_large_image.urlString))!, completed: nil);
            avatalImage.sd_setImage(with: URL.init(string: (aNews.user_info.avatar_url))!, completed: nil);
            
            if  aNews.label_style == 3 {
                authorLabel.text = aNews.app_name != "" ? aNews.app_name : aNews.ad_button.app_name;
            } else {
//                authorLabel.text = aNews.user_info.name;
            }
//            commonLabel.text = "评论 : \(aNews.video_detail_info.video_watch_count)";

        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
