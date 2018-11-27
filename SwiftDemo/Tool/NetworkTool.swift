//
//  NetworkTool.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/22.
//  Copyright © 2018年 qclong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkTool: NSObject {

    // 首页顶部导航栏搜索推荐标题内容
    static func loadHomeSearchInfo(completionHandler: @escaping(_ searchSuggest: String) ->()){
        
        let url = BASE_URL + "/search/suggest/homepage_suggest/?";
        let params = ["device_id": device_id,
                      "iid": iid];
                
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let data = json["data"].dictionary {
                    completionHandler(data["homepage_search_suggest"]!.string!)
                }
            }
        }
    }
    
    /// 首页顶部新闻标题的数据
    /// - parameter completionHandler: 返回标题数据
    /// - parameter newsTitles: 首页标题数组
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let dataDict = json["data"].dictionary {
                    if let datas = dataDict["data"]?.arrayObject {
                        print(JSON(datas));
                        let titles = [HomeNewsTitle](json: JSON(datas).rawString());
                        completionHandler(titles)
                    }
                }
            }
        }
    }
    
    /// 获取首页、视频、小视频的新闻列表数据
    /// - parameter category: 新闻类别
    /// - parameter ttFrom: 那个界面
    /// - parameter completionHandler: 返回新闻列表数据
    /// - parameter news: 首页新闻数据数组
    static func loadApiNewsFeeds(category: String, ttFrom: String, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ pullTime:TimeInterval, _ news: [NewsModel]) -> ()) {
        // 下拉刷新的时间
        let url = BASE_URL + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": listCount,
                      "category": category,
                      "min_behot_time": maxBehotTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]
        
        print(JSON(params).rawString());
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                
                var news = [NewsModel]();
                for item in datas {
                    news.append(NewsModel(json: JSON(item["content"]).rawString()));
                }
                completionHandler(maxBehotTime, news);
                
            }
        }
    }
    
    
    
    
    
    
}
