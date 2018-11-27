//
//  NewsHomeViewController.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/22.
//  Copyright © 2018年 qclong. All rights reserved.
//

import UIKit


class NewsHomeViewController: NewsBaseViewController,SGPageTitleViewDelegate,SGPageContentScrollViewDelegate {
    
    private var pageTitleView:SGPageTitleView?;
    private var pageContentScrollView:SGPageContentScrollView?;
    private lazy var addBtn: UIButton = {
        let btn = UIButton(type: .custom);
        btn.setImage(UIImage(named:"add_channel_titlbar_thin_new_16x16_" ), for: .normal);
        btn.frame = CGRect(x: screenWidth - newsTitleHeight, y: 0, width: newsTitleHeight, height: newsTitleHeight);
        btn.addTarget(self, action: #selector(addChannelBtnClick), for: .touchUpInside);
        btn.backgroundColor = UIColor.white;
        let lineView = UIView.init(frame: CGRect(x: 0, y: newsTitleHeight-0.5, width: newsTitleHeight, height: 0.5));
        lineView.backgroundColor = UIColor.lightGray;
        btn.addSubview(lineView);
        
        return btn;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = NewsNavigationBarView.loadViewFromNib();
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        self.view.backgroundColor = .white
        setupUI();
        
    }
    
    @objc func addChannelBtnClick(sender:UIButton) {
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension NewsHomeViewController {
    
    func setupUI(){

        NetworkTool.loadHomeNewsTitleData {
            self.pageTitleView(titleNames: $0.compactMap({$0.name}));
            _ = $0.compactMap({ (newsTitle) -> () in
                let vc = NewsMainViewController();
                vc.category = newsTitle.category;
                self.addChild(vc);
            })
            self.pageContentView();
            self.view.addSubview(self.addBtn);
        };
        
    }
    
    func pageTitleViewConfigure() -> SGPageTitleViewConfigure {
        let configure:SGPageTitleViewConfigure = SGPageTitleViewConfigure();
        configure.titleColor = .black
        configure.titleSelectedColor =  UIColor(red: 196/255.0, green: 73/255.0, blue: 67/255.0, alpha: 1)
        configure.indicatorColor = .clear
        return configure;
    }
    
    func pageTitleView(titleNames:Array<String>) {
        let pageTitleView:SGPageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth-newsTitleHeight, height: newsTitleHeight), delegate: self, titleNames: titleNames, configure: pageTitleViewConfigure());
        self.pageTitleView = pageTitleView;
        self.view.addSubview(pageTitleView);
    }
    
    func pageContentView(){
        let contentView:SGPageContentScrollView = SGPageContentScrollView(frame: CGRect(x: 0, y: newsTitleHeight, width: screenWidth, height: screenHeight-newsTitleHeight), parentVC: self, childVCs: self.children);
        contentView.delegatePageContentScrollView = self;
        self.pageContentScrollView = contentView;
        view.addSubview(contentView);
    }
    
}


extension NewsHomeViewController  {
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        print(selectedIndex);
        self.pageContentScrollView?.setPageContentScrollViewCurrentIndex(selectedIndex);
    }
    
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex);
    }
    
}

