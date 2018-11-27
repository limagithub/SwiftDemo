//
//  BaseNavigationController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/8.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class BaseNavigationController: UINavigationController {
    
    var interactivePopGestureRecognizerEnabled : Bool = true //全屏手势属性，默认开启
    fileprivate var pushing : Bool = false // 防止多次push一个页面的标识
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupNavigationBase()
        
        self.delegate = self
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的View中
        guard let gesView = systemGes.view else { return }
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target")  else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        panGes.delegate = self
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }
    
    //导航栏基本配置
    func setupNavigationBase(){
        
        
//        // item的颜色和图标颜色
//        self.navigationBar.tintColor =  UIColor.white // kMainAppColor
//        //bar的背景颜色
//        self.navigationBar.barTintColor = UIColor.colorWithHexString(hex: "#1961BF")
//        //kNavigationBarViewColor
//        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        //title字号颜色
        // self.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 17),NSForegroundColorAttributeName:UIColor.white]
        // self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:kMainAppColor]
        
    }
    
    //重写 pushViewController
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //防止多次push一个页面
        if pushing {
            return
        }
        else{
            pushing = true
        }
        // 隐藏要push的控制器的tabbar
    
        if self.viewControllers.count > 0 {
            //隐藏tabbar
           // NotificationCenter.default.post(name: NSNotification.Name("TabBarHide"), object: nil, userInfo: ["hide": true])
           MainTabBarController.shareInstance.hiddenTabBar(hide: true)
        }
        
       
        super.pushViewController(viewController, animated: animated)
        
    }
    
  
    
    

    
    override func popViewController(animated: Bool) -> UIViewController? {
        
        let pop = super.popViewController(animated: animated)
        return pop
        
    }
    
    

    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
}

// UINavigationControllerDelegate
extension BaseNavigationController : UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    
        if(self.viewControllers.count == 1) {
           //显示tabbar
           //NotificationCenter.default.post(name: NSNotification.Name("TabBarHide"), object: nil, userInfo: ["hide": false])
            MainTabBarController.shareInstance.hiddenTabBar(hide: false)
        }
        pushing = false
    }
    
}

//MARK:- UIGestureRecognizerDelegate
extension BaseNavigationController : UIGestureRecognizerDelegate{
    
    /**
     *  此代理方法为处理全屏Pop手势是否可用的首调方法
     *  在此方法中可以根据touch中的view类型来设置手势是否可用
     *  比如：界面中触摸到了按钮，则禁止使用手势
     */
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
       
        if !(gestureRecognizer.isKind(of: UIPanGestureRecognizer.self)) {
            return false
        }
        let  touchView = touch.view!
        if (touchView.isMember(of: UIButton.self)) || (touchView.isKind(of: UINavigationBar.self)){
            return false
        }
        return self.interactivePopGestureRecognizerEnabled
    }
    
    /**
     *  当方法gestureRecognizer:shouldReceiveTouch:返回的值为NO，此方法将不再被调用
     *  当此方法被调用时，全屏Pop手势是否可用要根据四个情况来确定
     *
     *  第一种情况：当前控制器为根控制器了，全屏Pop手势手势不可用
     *  第二种情况：如果导航栏Push、Pop动画正在执行（私有属性）时，全屏pop手势不可用
     *  第三种情况：手势是上下移动方向，全屏Pop手势不可用
     *  第四种情况：手势是右往左移动方向，全屏Pop手势不可用
     */
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if !(gestureRecognizer.isKind(of: UIPanGestureRecognizer.self)) {
            return false
        }
        let recognizer = gestureRecognizer as! UIPanGestureRecognizer
        let vTranslationPoint = recognizer.translation(in: recognizer.view)
        if fabsf(Float((vTranslationPoint.x))) > fabsf(Float((vTranslationPoint.y))) {
            let isRootViewController : Bool = self.viewControllers.count == 1
            let isTransitioning : Bool = self.value(forKey: "_isTransitioning") as! Bool
            let isPanPortraitToLeft : Bool = Float((vTranslationPoint.x)) < 0
            return !isRootViewController && !isTransitioning && !isPanPortraitToLeft
        }
        
        return false
    }
    
    
    
}
