//
//  MainTabBarController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/8.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController


let tabbarHeight: CGFloat = UIDevice.isiPhoneX() ? (49 + 34) : 49


class MainTabBarController: UITabBarController{

    //tabbar单例
    static let shareInstance = MainTabBarController()
    //按键缩小大小
    let buttonX: CGFloat = 3
    let buttonH: CGFloat = 4
    //默认选中第几个tiem
    var index = 0
    
    //选中背景颜色
    let selectedbgColor: UIColor = UIColor(red:0.19, green:0.43, blue:0.90, alpha:1.00)
    //中间items 的颜色
    let middlebgColor: UIColor = UIColor(red:0.18, green:0.77, blue:0.36, alpha:1.00)
    //动画按键数组
    var tabbarArray: [HLAnimationButton] = [HLAnimationButton]()
    //tabbar背景
    var tabbarview = UIView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //清除顶部线条
        self.clearTabBarTopLine()
        print("手机型号：\(UIDevice.iphoneType())")
        self.tabbarview = UIView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - tabbarHeight, width: UIScreen.main.bounds.size.width, height: tabbarHeight))
        self.tabbarview.backgroundColor = UIColor.black
        self.view.addSubview(self.tabbarview)
        
        //创建子控制器
        self.creatSubViewCtrs()
        
        
    }
    
    
    //MARK:清除顶部线条
    fileprivate func clearTabBarTopLine(){
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.clear.cgColor)
        
        context?.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.tabBar.backgroundImage = img
        self.tabBar.shadowImage = img
    }
    
    
    
    //MARK: 界面创建
    fileprivate func creatSubViewCtrs(){
        let firstVC = ChatListViewController()
        let firstNAV = BaseNavigationController(rootViewController: firstVC)
        let firsttabbaritem = HLAnimationButton(frame: CGRect(x: buttonX, y: buttonH, width: self.tabbarview.bounds.size.width/5 - 2 * buttonX, height: 49 - 2 * buttonH))
        firsttabbaritem.bgSelectedColor = selectedbgColor
        firsttabbaritem.textColor = UIColor.gray
        firsttabbaritem.iconColor = UIColor.gray
        firsttabbaritem.creatTitleAndIcon(title: "聊天", icon: UIImage(named: "chat")!)
        firsttabbaritem.animation = RAMBounceAnimation()
        firsttabbaritem.animation.textSelectedColor = .white
        firsttabbaritem.animation.iconSelectedColor = .white
        firsttabbaritem.tag = 0
        firsttabbaritem.addTarget(self, action: #selector(tapHandler(button:)), for: UIControl.Event.touchUpInside)
        
        self.tabbarview.addSubview(firsttabbaritem)
        
        
        
        let secondVC = NewsHomeViewController()
        let secondNAV = BaseNavigationController(rootViewController: secondVC)
        let secondtabbaritem = HLAnimationButton(frame: CGRect(x: self.tabbarview.bounds.size.width/5 + buttonX, y: buttonH, width: self.tabbarview.bounds.size.width/5 - buttonX * 2, height: 49 - buttonH * 2))
        secondtabbaritem.bgSelectedColor = selectedbgColor
        secondtabbaritem.textColor = UIColor.gray
        secondtabbaritem.iconColor = UIColor.gray
        secondtabbaritem.creatTitleAndIcon(title: "新闻", icon: UIImage(named: "news")!)
        secondtabbaritem.animation = RAMLeftRotationAnimation()
        secondtabbaritem.animation.iconSelectedColor = .white
        secondtabbaritem.animation.textSelectedColor = .white
        secondtabbaritem.tag = 1
        secondtabbaritem.addTarget(self, action: #selector(tapHandler(button:)), for: UIControl.Event.touchUpInside)
        self.tabbarview.addSubview(secondtabbaritem)
        
        
        
        
        let thirdVC = RadarViewController.shareInstance
        let thirdNAV = BaseNavigationController(rootViewController: thirdVC)
        
        let thirdtabbaritem = HLAnimationButton(frame: CGRect(x: self.tabbarview.bounds.size.width/5 * 2, y: -11, width: self.tabbarview.bounds.size.width/5, height: 55))
        thirdtabbaritem.textColor = UIColor.white
        thirdtabbaritem.iconColor = UIColor.white
        thirdtabbaritem.creatTitleAndIcon(title: "雷达", icon: UIImage(named: "radar1")!)
        let frameAnimation = RAMFrameItemAnimation()
        frameAnimation.imagesPath = "ToolsAnimation"
        frameAnimation.awakeFromNib()
        frameAnimation.textSelectedColor = UIColor.white
        frameAnimation.iconSelectedColor = UIColor.white
        thirdtabbaritem.animation = frameAnimation
        thirdtabbaritem.bgSelectedColor = middlebgColor
        thirdtabbaritem.backgroundColor = middlebgColor
        thirdtabbaritem.tag = 2
        self.animation(thirdtabbaritem)
        thirdtabbaritem.addTarget(self, action: #selector(tapHandler(button:)), for: UIControl.Event.touchUpInside)
        self.tabbarview.addSubview(thirdtabbaritem)
        
        
        
        
        let fourthVC = FourthViewController()
        let fourthNAV = BaseNavigationController(rootViewController: fourthVC)
        let fourthtabbaritem = HLAnimationButton(frame: CGRect(x: self.tabbarview.bounds.size.width/5 * 3 + buttonX, y: buttonH, width: self.tabbarview.bounds.size.width/5 - buttonX * 2, height: 49 - buttonH * 2))
        fourthtabbaritem.bgSelectedColor = selectedbgColor
        fourthtabbaritem.textColor = UIColor.gray
        fourthtabbaritem.iconColor = UIColor.gray
        fourthtabbaritem.creatTitleAndIcon(title: "微博", icon: UIImage(named: "weibo")!)
        fourthtabbaritem.animation = RAMFlipRightTransitionItemAnimations()
        fourthtabbaritem.animation.textSelectedColor = .white
        fourthtabbaritem.animation.iconSelectedColor = .white
        fourthtabbaritem.tag = 3
        fourthtabbaritem.addTarget(self, action: #selector(tapHandler(button:)), for: UIControl.Event.touchUpInside)
        self.tabbarview.addSubview(fourthtabbaritem)
        
        
        
        let fifthVC = FifthViewController()
        let fifthNAV = BaseNavigationController(rootViewController: fifthVC)
        let fifthtabbaritem = HLAnimationButton(frame: CGRect(x: self.tabbarview.bounds.size.width/5 * 4 + buttonX, y: buttonH, width: self.tabbarview.bounds.size.width/5 - buttonX * 2, height: 49 - buttonH * 2))
        fifthtabbaritem.bgSelectedColor = selectedbgColor
        fifthtabbaritem.textColor = UIColor.gray
        fifthtabbaritem.iconColor = UIColor.gray
        fifthtabbaritem.creatTitleAndIcon(title: "太阳系", icon: UIImage(named: "starsystem")!)
        fifthtabbaritem.animation =  RAMFumeAnimation()
        fifthtabbaritem.animation.textSelectedColor = .white
        fifthtabbaritem.animation.iconSelectedColor = .white
        fifthtabbaritem.tag = 4
        fifthtabbaritem.addTarget(self, action: #selector(tapHandler(button:)), for: UIControl.Event.touchUpInside)
        self.tabbarview.addSubview(fifthtabbaritem)
        
        
        tabbarArray = [firsttabbaritem,secondtabbaritem,thirdtabbaritem,fourthtabbaritem,fifthtabbaritem]
        let tabArray = [firstNAV,secondNAV,thirdNAV,fourthNAV,fifthNAV]
        self.viewControllers = tabArray
        
        
        let selecteditem: HLAnimationButton = tabbarArray[index]
        selecteditem.selectedState()
        selecteditem.backgroundColor = selectedbgColor
        self.selectedIndex = index
    }
    
    
    
    
    
    // MARK: 呼吸动画
    fileprivate func animation(_ view: UIView){
        
        let layer = view.layer
        layer.cornerRadius = 5.0
        
        //大小
        let scaleAnimate = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimate.fromValue = 0.95
        scaleAnimate.toValue = 1.0
        scaleAnimate.autoreverses = true
        scaleAnimate.repeatCount = MAXFLOAT
        scaleAnimate.duration = 0.8
        
        //透明度
        let opaqueAnimate = CABasicAnimation(keyPath: "opacity")
        opaqueAnimate.fromValue = 0.7
        opaqueAnimate.toValue = 1
        opaqueAnimate.autoreverses = true
        opaqueAnimate.repeatCount = MAXFLOAT
        opaqueAnimate.duration = 0.8
        
        //把剧本交给演员开始动画
        layer.add(scaleAnimate, forKey: "scaleAnimate")
        //layer.add(opaqueAnimate, forKey: "opacityAnimate")
        
        
        
    }
    
    
    
    
    
    @objc open func tapHandler(button: HLAnimationButton) {
        
        let items = tabbarArray
        let gestureView = button
        
        let currentIndex = gestureView.tag
        
        if items[currentIndex].isEnabled == false { return }
        
        let controller = self.children[currentIndex]
        
        if let shouldSelect = delegate?.tabBarController?(self, shouldSelect: controller)
            , !shouldSelect {
            return
        }
        
        
        
        if selectedIndex != currentIndex {
            let animationItem : HLAnimationButton = items[currentIndex]
            animationItem.playAnimation()
            
            let deselectItem = items[selectedIndex]
            
            let containerPrevious : UIView = deselectItem.iconView!.icon.superview!
            containerPrevious.backgroundColor = items[currentIndex].bgDefaultColor
            let middle = items[2]
            middle.backgroundColor = middlebgColor
            
            if currentIndex == 2{
                middle.layer.removeAllAnimations()
            }else{
                self.animation(middle)
            }
            
            deselectItem.deselectAnimation()
            
            let container : UIView = animationItem.iconView!.icon.superview!
            container.backgroundColor = items[currentIndex].bgSelectedColor
            
            
            selectedIndex = gestureView.tag
            delegate?.tabBarController?(self, didSelect: controller)
            
        }else if selectedIndex == currentIndex {
            
            if let navVC = self.viewControllers![selectedIndex] as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            }
        }
    }
    
    
    
    
    
    
    // MARK: 隐藏tabbar
    
    func hiddenTabBar(hide: Bool){
        if self.tabBar.isHidden != hide{
            if hide{
                UIView.animate(withDuration: 0.4, animations: {
                    self.tabbarview.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height + 11, width: UIScreen.main.bounds.size.width, height: tabbarHeight)
                }, completion: { (_) in
                    
                    self.tabbarview.isHidden = hide
                    self.tabBar.isHidden = hide
                    
                })
                
            }else{
                self.tabBar.isHidden = hide
                self.tabbarview.isHidden = hide
                self.tabbarview.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height + 11, width: UIScreen.main.bounds.size.width, height: tabbarHeight)
                UIView.animate(withDuration: 0.4, animations: {
                    self.tabbarview.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - tabbarHeight, width: UIScreen.main.bounds.size.width, height: tabbarHeight)
                }, completion: { (_) in
                    
                })
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
