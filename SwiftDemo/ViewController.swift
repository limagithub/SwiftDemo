//
//  ViewController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/8.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
        //MBProgressHUD.showIndeterminateHUDWithMessage(message: "加载中")
        MBProgressHUD.showSuccessHUDWithMessage(message: "成功", andTime: 2.9)
        MBProgressHUD.showFailureHUDWithMessage(message: "失败", andTime: 2.9)
       // MBProgressHUD.showHUDWithMessage(message: "登陆成功", and: 1.6)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//            print("时间到")
//            MBProgressHUD.dismiss()
//        }
    }


}

