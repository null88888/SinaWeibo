//
//  WBNavigationBar.swift
//  新浪微博
//
//  Created by ljw on 2018/9/10.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

class WBNavigationBar: UINavigationBar {

    //ios11下的navigationBar上的UINavigationBarContentView的y上移到了0的位置，重新布局修改
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in subviews {
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            
            if stringFromClass.contains("BarBackground") {
                subview.frame = bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subview.frame = CGRect(x: 0, y: 20, width: UIScreen.cz_screenWidth(), height: 44)
            }
        }
    }

}
