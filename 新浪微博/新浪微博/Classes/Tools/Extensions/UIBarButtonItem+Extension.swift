//
//  UIBarButtonItem+Extension.swift
//  新浪微博
//
//  Created by ljw on 2018/9/10.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建自定义UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 默认16 字体大小
    ///   - target: target
    ///   - action: action
    convenience init(title: String, fontSize: CGFloat = 16, target: Any?, action: Selector, isBack: Bool = false) {
        
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        }
        //btn.sizeToFit()
        
        
        self.init(customView: btn)
    }
}
