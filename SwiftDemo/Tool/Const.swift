//
//  Const.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/22.
//  Copyright © 2018年 qclong. All rights reserved.
//

import Foundation


/// 屏幕的宽度
let screenWidth = UIScreen.main.bounds.width
/// 屏幕的高度
let screenHeight = UIScreen.main.bounds.height
let image3Width: CGFloat = (screenWidth - 40) / 3


/// 服务器地址

let BASE_URL = "https://is.snssdk.com"

let device_id: Int = 6096495334
let iid: Int = 5034850950

let isIPhoneX: Bool = screenHeight == 812 ? true : false

let newsTitleHeight: CGFloat = 40
let kMyHeaderViewHeight: CGFloat = 280
let kUserDetailHeaderBGImageViewHeight: CGFloat = 146


/// 关注的用户详情界面 topTab 的按钮的宽度
let topTabButtonWidth: CGFloat = screenWidth * 0.2
/// 关注的用户详情界面 topTab 的指示条的宽度 和 高度
let topTabindicatorWidth: CGFloat = 40
let topTabindicatorHeight: CGFloat = 2


