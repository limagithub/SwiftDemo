//
//  RadarAnimationView.swift
//  LearnSwift
//
//  Created by 张海禄 on 2017/2/20.
//  Copyright © 2017年 张海禄. All rights reserved.
//

import UIKit

class RadarAnimationView: UIView {

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override  init(frame: CGRect){
        super.init(frame: frame)
        self.frame = frame
        
        let logo = UIImageView.init(frame: CGRect(x: self.center.x - 25, y: self.center.y - 25, width: 50, height: 50 ))
        logo.backgroundColor = UIColor.clear
        logo.image = UIImage(named: "logoA")
        self.addSubview(logo)

        
        let timer:Timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(creatRadarViews), userInfo: nil, repeats: true)
        timer.fire()
    }

        
    
    @objc func creatRadarViews() {
        
        let scale:CGFloat = self.bounds.size.height / 30
        let view = self.circleView()
        view.backgroundColor = UIColor.init(red: 61/255, green: 107/255, blue: 147/255, alpha: 1.0)
        self.insertSubview(view, at: 0)
    
        UIView.animate(withDuration: 5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                view.transform = CGAffineTransform.init(scaleX: scale, y: scale)
                view.backgroundColor = UIColor.init(red: 35/255, green: 39/255, blue: 63/255, alpha: 1.0)
                view.alpha = 0
                
            }, completion: { (_) in
                view.removeFromSuperview()
                })
        
           }
    
    
    func circleView() -> UIView {
        let view = UIView.init(frame: CGRect(x: (self.bounds.size.width - 30)/2, y: (self.bounds.size.height - 30)/2, width: 30, height: 30))
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
        return view
    }
    
    
    
    //MARK: 出现头像
    func showMembers(array: NSArray){
        
        let view = UIView.init(frame: CGRect(x: 60, y: 110, width: 40, height: 40))
        view.backgroundColor = UIColor.gray
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        self.addSubview(view)
    
    }

    
    
}
