//
//  NewsMainViewController.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/22.
//  Copyright © 2018年 qclong. All rights reserved.
//

import UIKit

class NewsMainViewController: NewsBaseViewController{

    var category:String = "";
    private var listCount:Int = 0;
    private var minBehotTime:TimeInterval = Date().timeIntervalSince1970;
    private var newsList = [NewsModel]();
    
    
    private lazy var  tableView:UITableView = {
        var frame = self.view.bounds;
        frame.size.height -= (newsTitleHeight + (self.navigationController?.navigationBar.height)!);
        let tableView = UITableView(frame: frame, style: .plain);
        tableView.register(UINib.init(nibName: "NoImageCell", bundle: nil), forCellReuseIdentifier: "NoImageCell");
        tableView.register(UINib.init(nibName: "HomeUserCell", bundle: nil), forCellReuseIdentifier: "HomeUserCell");
        tableView.register(UINib.init(nibName: "TheyAlsoUseCell", bundle: nil), forCellReuseIdentifier: "TheyAlsoUseCell");
        tableView.register(UINib.init(nibName: "RightImageCell", bundle: nil), forCellReuseIdentifier: "RightImageCell");
        tableView.register(UINib.init(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "VideoCell");
        tableView.register(UINib.init(nibName: "ThreeImageCell", bundle: nil), forCellReuseIdentifier: "ThreeImageCell");
        tableView.register(UINib.init(nibName: "TableViewVideoCell", bundle: nil), forCellReuseIdentifier: "TableViewVideoCell");

//TableViewVideoCell
//ThreeImageCell
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor = UIColor.clear;
        tableView.estimatedRowHeight = 44;
        return tableView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRefresh();
        self.tableView.mj_header.beginRefreshing();
        self.view.addSubview(tableView);
        
        
    }
    
    func setRefresh() {
       
        let refreshHeader = RefreshGifHeader { [weak self] in

            self?.minBehotTime = Date().timeIntervalSince1970;
            self?.senderRequestNetwork(ttFrom: "pull", listCount: 15, complateHandle: { (pullTime, newsInfo:[NewsModel]) in
                self?.minBehotTime = pullTime;
                self?.newsList = newsInfo;
                self?.tableView.reloadData();
                self?.tableView.mj_header.endRefreshing();
                self?.tableView.separatorColor = UIColor.grayColor210();

            });
        }
        
        
        tableView.mj_footer = RefreshGifFooter { [weak self] in
            self?.senderRequestNetwork(ttFrom: "load_more", listCount: (self?.newsList.count)!, complateHandle: { (pullTime, newsInfo) in
                self?.newsList += newsInfo;
                self?.tableView.reloadData();
                self?.tableView.mj_footer.endRefreshing();
                self?.tableView.separatorColor = UIColor.grayColor210();
            });
        }
        
        tableView.mj_header = refreshHeader;
        refreshHeader?.lastUpdatedTimeLabel.isHidden = true;
        refreshHeader?.isAutomaticallyChangeAlpha = true;
        tableView.mj_footer.isAutomaticallyChangeAlpha = true;
    }

    func senderRequestNetwork(ttFrom:String, listCount:Int, complateHandle:@escaping (_ pullTime:TimeInterval, _ news: [NewsModel]) -> ()) {
        
        NetworkTool.loadApiNewsFeeds(category: category, ttFrom: ttFrom, maxBehotTime: self.minBehotTime, listCount: listCount) { (pullTime:TimeInterval, newsInfo:[NewsModel]) in
            complateHandle(pullTime, newsInfo);
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}



extension NewsMainViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aNews = self.newsList[indexPath.row];
        
        if category == "video" { // TableViewVideoCell
            let cell:TableViewVideoCell = tableView.dequeueReusableCell(withIdentifier: "TableViewVideoCell") as! TableViewVideoCell;
            cell.aNews = aNews;
            tableView.separatorColor = UIColor.clear;
            return cell;
        } else {
            
            if aNews.cell_type == "32" {
                let cell:HomeUserCell = tableView.dequeueReusableCell(withIdentifier: "HomeUserCell") as! HomeUserCell ;
                cell.aNews = aNews;
                return cell;
            } else if aNews.cell_type == "50" {
                let cell:TheyAlsoUseCell = tableView.dequeueReusableCell(withIdentifier: "TheyAlsoUseCell") as! TheyAlsoUseCell;
                cell.theyUse = aNews.raw_data;
                return cell;
            } else {
                
                if aNews.video_duration != 0 && aNews.has_video { // 有视频
                    if aNews.video_style == 0 {
                        var url = "";
                        if let image = aNews.image_list.first {
                            url = image.url;
                        } else if aNews.middle_image.url.count > 0 {
                            url = aNews.middle_image.url;
                        } else if let largeImage = aNews.large_image_list.first {
                            url = largeImage.url;
                        }
                        
                        let cell:RightImageCell = tableView.dequeueReusableCell(withIdentifier: "RightImageCell") as! RightImageCell;
                        cell.aNews = aNews;
                        cell.rightImageUrl = url;
                        return cell;
                    } else if aNews.video_style == 2 {
                        let cell:VideoCell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell;
                        cell.aNews = aNews;
                        return cell;
                    }
                } else {
                    
                    
                    if aNews.middle_image.url != "" && aNews.image_list.count == 0 {
                        let cell:RightImageCell = tableView.dequeueReusableCell(withIdentifier: "RightImageCell") as! RightImageCell;
                        cell.aNews = aNews;
                        cell.rightImageUrl = aNews.middle_image.url;
                        return cell;
                    } else {
                        if aNews.image_list.count == 1  { // 右侧显示图片
                            let cell:RightImageCell = tableView.dequeueReusableCell(withIdentifier: "RightImageCell") as! RightImageCell;
                            cell.aNews = aNews;
                            cell.rightImageUrl = (aNews.image_list.first?.url)!;
                            return cell;
                        } else if aNews.image_list.count >= 2  {
                            let cell:ThreeImageCell = tableView.dequeueReusableCell(withIdentifier: "ThreeImageCell") as! ThreeImageCell;
                            cell.aNews = aNews;
                            return cell;
                            
                        }
                    }
                    
                }
            
        }
        
            let cell:NoImageCell = tableView.dequeueReusableCell(withIdentifier: "NoImageCell") as! NoImageCell;
            cell.aNews = aNews;
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false);
    }
    
    
    
}

