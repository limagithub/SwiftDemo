//
//  NewsModel.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/22.
//  Copyright © 2018年 qclong. All rights reserved.
//

import UIKit


class NewsModel: EVObject  {
    var app_name = "";
    var ad_button = ADButton()
    var sub_title = "";
    var video_detail_info = VideoDetailInfo()
    var video_duration = 0;
    var has_video = false;
    var raw_data = SmallVideo() //小视频数据
    var label_style:Int = 0;
    var is_stick:Bool = false;
    var abstract = "";
    var action_extra = "";
    var action_list = [ActionList]();
    var aggr_type = "";
    var allow_download = "";
    var article_sub_type = "";
    var article_type = "";
    var article_url = "";
    var article_version = "";
    var ban_comment = "";
    var behot_time = "";
    var bury_count = "";
    var cell_flag = "";
    var cell_layout_style = "";
    var cell_type = "";
    var comment_count = ""; // 评论数量
    var forward_count = "";
    var content_decoration = "";
    var control_panel = ControlPanel();
    var cursor = "";
    var digg_count = "";
    var display_url = "";
    var filter_words = [FilterWords]();
    var forward_info = ForwardInfo();
    var gallary_image_count = "";
    var group_id = "";
    var has_image = "";
    var has_m3u8_video = "";
    var has_mp4_video = "";
    var hot:Bool = false;
    var ignore_web_transform = "";
    var interaction_data = "";
    var is_subject = "";
    var item_id = "";
    var item_version = "";
    var keywords = "";
    var image_list = [ImageList]();
    var large_image_list = [ImageList]();
    var level = "";
    var log_pb = LogPb();
    var media_info = MediaInfo();
    var readCount = 0;
    var diggCount = 0;
    var media_name = "";
    var middle_image = MiddleImage();
    var need_client_impr_recycle = "";
    var publish_time:TimeInterval = 0;
    var read_count = "";
    var repin_count = "";
    var rid = "";
    var share_count = "";
    var share_info = ShareInfo();
    var share_url = "";
    var show_dislike = "";
    var show_portrait = "";
    var show_portrait_article = "";
    var source = "";
    var source_icon_style = "";
    var source_open_url = "";
    var tag = "";
    var tag_id = "";
    var tip = "";
    var title = "";
    var ugc_recommend = UgcRecommend();
    var url = "";
    var user_info = UserInfo();
    var user_repin = "";
    var user_verified = "";
    var verified_content = "";
    var video_style = -1;
    var article_alt_url = "";
    var label = "";
    var user = NewsUserInfo()
}

class  VideoDetailInfo: EVObject {
    var video_preloading_flag: Int = 0
    var direct_play: Int = 0
    var group_flags: Int = 0
    var detail_video_large_image = DetailVideoLargeImage()
    var video_third_monitor_url: String = ""
    var video_watching_count: Int = 0
    var videoWatchingCount: String { return video_watching_count.convertString() }
    var video_id: String = ""
    var video_watch_count: Int = 0
    var videoWatchCount: String { return video_watch_count.convertString() }
    var video_type: Int = 0
    var show_pgc_subscribe: Int = 0
}

class DetailVideoLargeImage: EVObject {
    var height: Int = 0
    var url_list: [URLList]!
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width: Int = 0
    var uri: String = ""
    
}


class SmallVideo: EVObject {
//    let emojiManager = EmojiManager()
    
    var rich_title: String = ""
    var group_id: Int = 0
    var status = Status()
    var thumb_image_list = [ThumbImage]()
    var title: String = ""
//    var attrbutedText: NSMutableAttributedString {
//        return emojiManager.showEmoji(content: title, font: UIFont.systemFont(ofSize: 17))
//    }
    
    var create_time: TimeInterval = 0
    var createTime: String { return create_time.convertString() }
    
    var recommand_reason: String = ""
//    var first_frame_image_list = [FirstFrameImage]()
    var action = SmallVideoAction()
    var app_download = AppDownload()
    var app_schema: String = ""
    var interact_label: String = ""
    var activity: String = ""
    var large_image_list = [MiddleImage]()
    var group_source  = 16
    var share = Share()
    var publish_reason = PublishReason()
    var music = Music()
    var title_rich_span: String = ""
    var user = User()
    var video = Video()
    var label: String = ""
    var label_for_list: String = ""
    var distance: String = ""
    var detail_schema: String = ""
    var item_id: Int = 0
    var animated_image_list = [AnimatedImage]()
    var video_neardup_id: Int = 0
    
    /// 他们也在用
    var user_cards = [UserCard]()
    var has_more = false
    var id = 0
    var show_more = ""
    var show_more_jump_url = ""
}

class ThumbImage: EVObject {
    var type = 1
    var height: CGFloat = 0
    
    var url_list = [URLList]()
    
    var url: NSString = ""
//    var urlString: String {
//        guard url.hasSuffix(".webp") else { return url as String }
//        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
//    }
    
    var width: CGFloat = 0
    
    var uri: String = ""
    
    /// 宽高比
    var ratio: CGFloat { return width / height }
    
}


class AppDownload: EVObject {
    var flag: Int = 0
    var text: String = ""
}


class User: EVObject {
    var relation_count = RelationCount()
    var relation = Relation()
    var info = Info()
}

class Info: EVObject {
    var medals: String = ""
    var avatar_url: String = ""
    var schema: String = ""
    var user_auth_info = UserAuthInfo()
    var user_id: Int = 0
    var desc: String = ""
    var ban_status: Bool = false
    var user_verified = false
    var verified_content: String = ""
    var media_id: String = ""
    var name: String = ""
    var user_decoration: String = ""
}

class Relation: EVObject {
    var is_followed = false
    var is_friend = false
    var is_following = false
    var remark_name: String = ""
}

class RelationCount: EVObject {
    var followings_count: Int = 0
    var followers_count: Int = 0
}


class NewsUserInfo: EVObject {
    var follow: Bool = false
    var name: String = ""
    var user_verified: Bool = false
    var verified_content: String = ""
    var user_id: Int = 0
    var id: Int = 0
    var desc: String = ""
    var avatar_url: String = ""
    var follower_count: Int = 0
    var followerCount: String { return follower_count.convertString() }
    var user_decoration: String!
    var subcribed: Int = 0
    var fans_count: Int = 0
    var fansCount: String { return fans_count.convertString() }
//    var special_column = [SpecialColumn]()
    var user_auth_info: String!
    var media_id: Int = 0
    var screen_name = ""
    var is_followed: Bool = false
    var is_following: Bool = false // 是否正在关注
    var is_blocking: Bool = false
    var is_blocked: Bool = false
    var is_friend: Bool = false
    var medals = [String]() // hot_post (热门内容)
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(
            keyInObject:"desc",
            keyInResource:"description"
            )]
    }
    
}


class Music: EVObject {
    var author: String = ""
    var music_id: Int = 0
    var title: String = ""
    var cover_large: String = ""
    var album: String = ""
    var cover_medium: String = ""
    var cover_thumb: String = ""
    var cover_hd: String = ""
}


class PublishReason: EVObject {
    var noun: String = ""
    var verb: String = ""
}

class Share: EVObject {
    var share_title: String = ""
    var share_url: String = ""
    var share_weibo_desc: String = ""
    var share_cover: String = ""
    var share_desc: String = ""
}

class Status: EVObject {
    var allow_share: Bool = false
    var allow_download: Bool = false
    var allow_comment: Bool = false
    var is_delete: Bool = false
}

class SmallVideoAction: EVObject {
    var bury_count = 0
    var comment_count = 0
    var digg_count = 0
    var forward_count = 0
    var play_count = 0
    var read_count = 0
    var user_bury = 0
    var user_repin = 0
    var user_digg = false
}


// MARK: 相关推荐模型
class UserCard: EVObject {
    
    var name: String = ""
    
    var recommend_reason: String = ""
    
    var recommend_type: Int = 0
    
    var user: UserCardUser = UserCardUser()
    
    var stats_place_holder: String = ""
    
}

// MARK: 相关推荐的用户模型
class UserCardUser: EVObject {
    
    var info: UserCardUserInfo = UserCardUserInfo()
    
    var relation: UserCardUserRelation = UserCardUserRelation()
    
}

// MARK: 相关推荐的用户信息模型
class UserCardUserInfo: EVObject {
    
    var name: String = ""
    
    var user_id: Int = 0
    
    var avatar_url: String = ""
    
    var desc: String = ""
    
    var schema: String = ""
    
    var user_auth_info = UserAuthInfo()
}

// MARK: 相关推荐的用户是否关注模型
class UserCardUserRelation: EVObject {
    
    var is_followed: Bool = false
    
    var is_following: Bool = false
    
    var is_friend: Bool = false
    
}



//class NewsUserInfo: EVObject {
//    var follow: Bool = false
//    var name: String = ""
//    var user_verified: Bool = false
//    var verified_content: String = ""
//    var user_id: Int = 0
//    var id: Int = 0
//    var desc: String = ""
//    var avatar_url: String = ""
//    var follower_count: Int = 0
//    var followerCount: String { return follower_count.convertString() }
//    var user_decoration: String!
//    var subcribed: Int = 0
//    var fans_count: Int = 0
//    var fansCount: String { return fans_count.convertString() }
////    var special_column = [SpecialColumn]()
//    var user_auth_info: String!
//    var media_id: Int = 0
//    var screen_name = ""
//    var is_followed: Bool = false
//    var is_following: Bool = false // 是否正在关注
//    var is_blocking: Bool = false
//    var is_blocked: Bool = false
//    var is_friend: Bool = false
//    var medals = [String]() // hot_post (热门内容)
//    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
//        return [(
//            keyInObject:"desc",
//            keyInResource:"description"
//            )]
//    }
//}


class ControlPanel: EVObject {
    var recommend_sponsor = RecommendSponsor();
}

class RecommendSponsor: EVObject {
    var icon_url = "";
    var label = "";
    var night_icon_url = "";
    var target_url = "";
}


class ActionList: EVObject {
    var action = "";
    var desc = "";
    var extra = Extra();
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(
            keyInObject:"desc",
            keyInResource:"description"
            )]
    }
}

class Extra: EVObject {
    
}


class FilterWords: EVObject {
    var id = "";
    var is_selected = false;
    var name = "";
}

class ForwardInfo: EVObject {
    var forward_count = 0;
}

class ImageList: EVObject {
    var height = 0;
    var uri = "";
    var url = "";
    var url_list = [UrlList]();
    var width = 0;
}

class UrlList: EVObject {
    var url = "";
}

class LogPb: EVObject {
    var impr_id = "";
    var is_following = "";
}

class MediaInfo: EVObject {
    var avatar_url = "";
    var follow = false;
    var is_star_user = false;
    var media_id = 0;
    var name = "";
    var recommend_reason = "";
    var recommend_type = 0;
    var user_id = 0;
    var user_verified = false;
    var verified_content = "";
}

class MiddleImage: EVObject {
    var height = 0;
    var uri = "";
    var url:String = "";
    var url_list = [UrlList]();
    var width = 0;
}

class ShareInfo: EVObject{
    var cover_image = "";
    var desc = "";
    var on_suppress = "";
    var share_type = ShareType();
    var share_url = "";
    var title = "";
    var token_type = "";
    var weixin_cover_image = WeixinCoverImage();
}

class ShareType: EVObject {
    var pyq = "";
    var qq = "";
    var qzone = "";
    var wx = "";
}

class WeixinCoverImage: EVObject {
    var height = 0;
    var uri = "";
    var url = "";
    var url_list = [UrlList]();
    var width = 0;
}

class UgcRecommend: EVObject {
    var activity = "";
    var reason = "";
}

class UserInfo: EVObject {
    var avatar_url = "";
    var desc = "";
    var follow = false;
    var follower_count = 0;
    var name = "";
    var schema = "";
    var user_auth_info = UserAuthInfo();
    var user_id = 0;
    var user_verified = true;
    var verified_content = "";
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(
            keyInObject:"desc",
            keyInResource:"description"
            )]
    }
}

class UserAuthInfo: EVObject {
    var auth_type = "";
    var auth_info = "";
    var __text = "";

}


class Video: EVObject {
    var logo_name: String = ""
    var coded_format: String = ""
    var vwidth: Int = 0
    var socket_buffer: Int = 0
    var preload_interval: Int = 0
    var preload_size: Int = 0
    var preload_min_step: Int = 0
    var bitrate: Int = 0
    var size: Int = 0
    /// 用 base 64 加密的视频真实地址
    var main_url: String = ""
    var mainURL: String {
        let decodeData = Data(base64Encoded: main_url, options: Data.Base64DecodingOptions(rawValue: 0))
        return String(data: decodeData!, encoding: .utf8)!
    }
    
    var user_video_proxy: Int = 0
    var backup_url_1: String = ""
    var preload_max_step: Int = 0
    var definition: String = ""
    var vheight: Int = 0
    var vtype: String = ""
    var height: Int = 0
    var download_addr = DownloadAddr()
    var play_addr = PlayAddr()
    var origin_cover = OriginCover()
    var width: Int = 0
    var duration: CGFloat = 0.0
    var video_id: String = ""
    var ratio: String = ""
}

class DownloadAddr: EVObject {
    var uri: String = ""
    var url_list = [String]()
}

class PlayAddr: EVObject {
    var uri: String = ""
    var url_list = [String]()
}

class OriginCover: EVObject {
    var uri: String = ""
    var url_list = [String]()
}

class AnimatedImage: EVObject {
    var uri: String = ""
    var image_type: Int = 0
    var url_list = [URLList]()
    var url: String = ""
    var width: Int = 0
    var height: Int = 0
}

class URLList: EVObject {
    
    var url: String = ""
}


class ADButton: EVObject {
    var desc: String = ""
    var download_url: String = ""
    var id: Int = 0
    var web_url: String = ""
    var app_name: String = ""
    var track_url: String = ""
    var ui_type: Int = 0
    var click_track_url: String = ""
    var button_text: String = ""
    var display_type: Int = 0
    var hide_if_exists: Int = 0
    var open_url: String = ""
    var source: String = ""
    var type: String = ""
    var package: String = ""
    var appleid: String = ""
    var web_title: String = ""
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(
            keyInObject:"desc",
            keyInResource:"description"
            )]
    }
}


