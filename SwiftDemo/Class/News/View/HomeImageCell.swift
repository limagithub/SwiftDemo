//
//  HomeImageCell.swift
//  News
//
//  Created by 杨蒙 on 2018/2/6.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class HomeImageCell: UICollectionViewCell {

    
    func setImage(image:ImageList) {
        imageView.sd_setImage(with: URL.init(string: image.url), completed: nil);

    }
    
    var image = ImageList() {
        didSet {
//            imageView.kf.setImage(with: URL(string: image.urlString)!)
            imageView.sd_setImage(with: URL.init(string: image.url.suffixWebpToPng()), completed: nil);

        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        theme_backgroundColor = "colors.cellBackgroundColor"
    }

}
