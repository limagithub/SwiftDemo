//
//  NewsNavigationBarView.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/22.
//  Copyright © 2018年 qclong. All rights reserved.
//

import UIKit

class NewsNavigationBarView: UIView,NibLoadable {

    
    @IBOutlet weak var avatarBtn: UIButton!
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        NetworkTool.loadHomeSearchInfo { (suggest) in
            print(suggest);
            self.searchBtn.setTitle(suggest, for: .normal)
        }
        
    }
    
    
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44.0);
        }
    }
   
    /// 固有的大小
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    @IBAction func avatarBtnClick(_ sender: Any) {
    }
    
    @IBAction func cameraBtnClick(_ sender: Any) {
    }
    
    @IBAction func searchBtnClick(_ sender: Any) {
    }
    
    
    
}
