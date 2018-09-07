//
//  WBBaseNavigationController.swift
//  新浪微博
//
//  Created by ljw on 2018/9/7.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

class WBBaseNavigationController: UINavigationController {

    // 重写push ，所有的push都会调用这个方法，
    // UINavigationController 设置跟视图时也会调用push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //为根视图时 childViewControllers.count == 0
        //当不是跟视图时才隐藏tabBar
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

}
