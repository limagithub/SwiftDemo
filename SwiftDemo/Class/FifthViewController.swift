//
//  FifthViewController.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/22.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import SnapKit

class FifthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "ARKit"
        let button = UIButton.init(type: .custom)
        button.setTitle("进入太阳系", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = UIColor.white
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(45)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        button.addTarget(self, action: #selector(pushSSViewController), for: .touchUpInside)
    }
    

    @objc func pushSSViewController() {
       
        self.navigationController?.pushViewController(SunSystemVC(), animated: true)
        
    }
 
}
