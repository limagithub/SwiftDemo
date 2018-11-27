//
//  String+Extension.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/23.
//  Copyright © 2018年 qclong. All rights reserved.
//

import Foundation

extension String {
    
    func suffixWebpToPng() -> (String) {
        let url:String = self;
        guard url.hasSuffix(".webp") else { return url as String }
        return (url as NSString).substring(to: url.count - 5) + ".png";
    }
    
}
