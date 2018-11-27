//
//  MBProgressHUD+Extension.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/8.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import Foundation
import UIKit


extension MBProgressHUD {
    
    //菊花加文字
    class func showIndeterminateHUDWithMessage (message: String) {
        self.dismiss()
        let view = viewToShow()
        let mbpHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        mbpHUD.labelText = message
        mbpHUD.mode = MBProgressHUDMode.indeterminate
        mbpHUD.animationType = MBProgressHUDAnimation.zoomOut
        mbpHUD.removeFromSuperViewOnHide = true
    }
    
    //单纯文字
    class func showHUDWithMessage (message: String, andTime: TimeInterval) {
        self.dismiss()
        let view = viewToShow()
        let mbpHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        mbpHUD.labelText = message
        mbpHUD.mode = MBProgressHUDMode.text
        mbpHUD.animationType = MBProgressHUDAnimation.zoomOut
        mbpHUD.removeFromSuperViewOnHide = true
        mbpHUD.hide(true, afterDelay: andTime)
    }
    
    //成功样式加文字
    class func showSuccessHUDWithMessage (message: String, andTime: TimeInterval) {
        self.dismiss()
        let view = viewToShow()
        let mbpHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        mbpHUD.labelText = message
        mbpHUD.customView = UIImageView.init(image: UIImage.init(named: "hud_success.png"))
        mbpHUD.mode = MBProgressHUDMode.customView
        mbpHUD.animationType = MBProgressHUDAnimation.zoomOut
        mbpHUD.removeFromSuperViewOnHide = true
        mbpHUD.hide(true, afterDelay: andTime)
    }
    
    //失败样式加文字
    class func showFailureHUDWithMessage (message: String, andTime: TimeInterval) {
        self.dismiss()
        let view = viewToShow()
        let mbpHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        mbpHUD.labelText = message
        mbpHUD.customView = UIImageView.init(image: UIImage.init(named: "hud_failure.png"))
        mbpHUD.mode = MBProgressHUDMode.customView
        mbpHUD.animationType = MBProgressHUDAnimation.zoomOut
        mbpHUD.removeFromSuperViewOnHide = true
        mbpHUD.hide(true, afterDelay: andTime)
    }
    
    //隐藏hud
    class func dismiss () {
       _ = MBProgressHUD.hideHUDForView(viewToShow(), animated: true)
    }
    
    
    //获取用于显示提示框的view
    class func viewToShow() -> UIView {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin;
                    break
                }
            }
        }
       
        return window!.rootViewController!.view
    }
    
}
