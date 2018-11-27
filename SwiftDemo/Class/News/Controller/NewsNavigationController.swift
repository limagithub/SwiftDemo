//
//  NewsNavigationController.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/22.
//  Copyright © 2018年 qclong. All rights reserved.
//

import UIKit

class NewsNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBar = UINavigationBar.appearance();
        navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default);
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white];
        navigationBar.tintColor = UIColor.white;
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        
        super.pushViewController(viewController, animated:animated );
        
    }
    
    @objc private func navigationBack(){
        popViewController(animated: true);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
