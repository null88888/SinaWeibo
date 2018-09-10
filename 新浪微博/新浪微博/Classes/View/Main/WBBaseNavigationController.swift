//
//  WBBaseNavigationController.swift
//  新浪微博
//
//  Created by ljw on 2018/9/7.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

class WBBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
    }
    
    // 重写push ，所有的push都会调用这个方法，
    // UINavigationController 设置跟视图时也会调用push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //为根视图时 childViewControllers.count == 0
        //当不是跟视图时才隐藏tabBar
        //viewController 是被push的控制器，设置他的左侧按钮作为返回按钮
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            //判断控制器的类型
            if let vc = viewController as? WBBaseViewController {
                var title = "返回"
                
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                //取出自定义的 navItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent))
            }
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    //POP返回上一级控制器
    @objc private func popToParent() {
        popViewController(animated: true)
    }

}
