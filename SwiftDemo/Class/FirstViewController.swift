//
//  FirstViewController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/9.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
        let button = UIButton.init(frame: CGRect(x: 50, y: 100, width: 60, height: 60))
            button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(pushView), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
       
        
    }
    

    @objc func pushView () {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
