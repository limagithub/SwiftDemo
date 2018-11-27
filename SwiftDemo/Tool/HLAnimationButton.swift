//
//  HLAnimationButton.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/9.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class HLAnimationButton: UIButton {

    @IBOutlet open var animation: RAMItemAnimation!
    //圆角大小
    @IBInspectable open var radius: CGFloat = 5
    //偏移量
    @IBInspectable open var yOffSet: CGFloat = 3
    //按键文字大小
    @IBInspectable open var textFont: UIFont = UIFont.systemFont(ofSize: 11)
    //按键普通状态下文字颜色
    @IBInspectable open var textColor: UIColor = UIColor.black
    //按键选中下文字颜色
    @IBInspectable open var selectedtextColor: UIColor = UIColor.white
    //图标普通状态下颜色
    @IBInspectable open var iconColor: UIColor = UIColor.clear
    //图标选中状态下颜色
    @IBInspectable open var selectediconColor: UIColor = UIColor.white
    
    
    open var iconView: (icon: UIImageView, textLabel: UILabel)?
    
    //背景色
    var bgDefaultColor: UIColor = UIColor.clear
    var bgSelectedColor: UIColor = UIColor.clear
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.frame = frame
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        //self.backgroundColor = bgDefaultColor
        //self.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
    }
    
    open func creatTitleAndIcon (title: NSString, icon: UIImage){
        
        self.backgroundColor = bgDefaultColor
        let renderMode = self.iconColor.cgColor.alpha == 0 ? UIImage.RenderingMode.alwaysOriginal :
            UIImage.RenderingMode.alwaysTemplate
        
        let iconImageView = UIImageView(image: icon.withRenderingMode(renderMode))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = self.iconColor
        
        let textLabel = UILabel()
        textLabel.text = title as String
        textLabel.backgroundColor = UIColor.clear
        textLabel.textColor = self.textColor
        textLabel.font = self.textFont
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(iconImageView)
        createConstraints(iconImageView, container: self, size: icon.size, yOffset: -5 - self.yOffSet)
        
        self.addSubview(textLabel)
        let textLabelWidth = self.bounds.size.width - 5.0
        createConstraints(textLabel, container: self, size: CGSize(width: textLabelWidth , height: 10), yOffset: 16 - self.yOffSet)
        
        self.iconView = (icon:iconImageView, textLabel:textLabel)
        
    }
    
    func buttonAction(button: HLAnimationButton){
        
        self.isSelected = !self.isSelected;
        if self.isSelected {
            self.playAnimation()
            
        } else {
            self.deselectAnimation()
        }
    }
    
    
    
    /**
     Start selected animation
     */
    open func playAnimation() {
        
        assert(animation != nil, "add animation in UITabBarItem")
        guard animation != nil && iconView != nil else  {
            return
        }
        animation.playAnimation(iconView!.icon, textLabel: iconView!.textLabel)
    }
    
    /**
     Start unselected animation
     */
    open func deselectAnimation() {
        
        guard animation != nil && iconView != nil else  {
            return
        }
        
        animation.deselectAnimation(
            iconView!.icon,
            textLabel: iconView!.textLabel,
            defaultTextColor: textColor,
            defaultIconColor: iconColor)
    }
    
    /**
     Set selected state without animation
     */
    open func selectedState() {
        guard animation != nil && iconView != nil else  {
            return
        }
        
        animation.selectedState(iconView!.icon, textLabel: iconView!.textLabel)
    }
    
    
    
    fileprivate func createConstraints(_ view:UIView, container:UIView, size:CGSize, yOffset:CGFloat) {
        
        let constX = NSLayoutConstraint(item: view,
                                        attribute: NSLayoutConstraint.Attribute.centerX,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: container,
                                        attribute: NSLayoutConstraint.Attribute.centerX,
                                        multiplier: 1,
                                        constant: 0)
        container.addConstraint(constX)
        
        let constY = NSLayoutConstraint(item: view,
                                        attribute: NSLayoutConstraint.Attribute.centerY,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: container,
                                        attribute: NSLayoutConstraint.Attribute.centerY,
                                        multiplier: 1,
                                        constant: yOffset)
        container.addConstraint(constY)
        
        let constW = NSLayoutConstraint(item: view,
                                        attribute: NSLayoutConstraint.Attribute.width,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: nil,
                                        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                        multiplier: 1,
                                        constant: size.width)
        view.addConstraint(constW)
        
        let constH = NSLayoutConstraint(item: view,
                                        attribute: NSLayoutConstraint.Attribute.height,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: nil,
                                        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                        multiplier: 1,
                                        constant: size.height)
        view.addConstraint(constH)
    }


}
