//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/8.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var chatViewModel: ChatViewModel!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.chatViewModel = ChatViewModel()
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarController.shareInstance
        self.window?.makeKeyAndVisible()
        
        let view = window!.rootViewController!.view!
        
       //启动效果
        let logoLayer = CALayer()
        logoLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        logoLayer.position = view.center
        logoLayer.contents = UIImage(named: "bianfu3")?.cgImage
        view.layer.mask = logoLayer
        
        let shelterView = UIView(frame: view.frame)
        shelterView.backgroundColor = .white
        view.addSubview(shelterView)
        
        window?.backgroundColor = UIColor.black
        
        let logoAnimation = CAKeyframeAnimation(keyPath: "bounds")
        logoAnimation.beginTime = CACurrentMediaTime() + 1
        logoAnimation.duration = 1.5
        logoAnimation.keyTimes = [0, 0.4, 1]
        logoAnimation.values = [NSValue(cgRect: CGRect(x: 0, y: 0, width: 100, height: 100)),
                                NSValue(cgRect: CGRect(x: 0, y: 0, width: 80, height: 80)),
                                NSValue(cgRect: CGRect(x: 0, y: 0, width: 6000, height: 6000))]
        logoAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
                                         CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)]
        logoAnimation.isRemovedOnCompletion = false
        logoAnimation.fillMode = CAMediaTimingFillMode.forwards
        logoLayer.add(logoAnimation, forKey: "zoomAnimation")
        
        let mainViewAnimation = CAKeyframeAnimation(keyPath: "transform")
        mainViewAnimation.beginTime = CACurrentMediaTime() + 1.1
        mainViewAnimation.duration = 1.0
        mainViewAnimation.keyTimes = [0, 0.5, 1]
        mainViewAnimation.values = [NSValue(caTransform3D: CATransform3DIdentity),
                                    NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.1, 1.1, 1)),
                                    NSValue(caTransform3D: CATransform3DIdentity)]
        view.layer.add(mainViewAnimation, forKey: "transformAnimation")
        view.layer.transform = CATransform3DIdentity
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveLinear, animations: {
            shelterView.alpha = 0
        }) { (_) in
            shelterView.removeFromSuperview()
            view.layer.mask = nil
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //NSKeyedArchiver.archiveRootObject(NSArray(), toFile: peerIDFilePath)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        RadarViewController.shareInstance.chatPeersArray.removeAllObjects()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

