//
//  WBMainViewController.swift
//  新浪微博
//
//  Created by ljw on 2018/9/7.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildViewControllers()

    }

}

// extension 类似于OC中的 分类， 在Swift中还可以用来分割代码
// 可以把相近功能的函数， 放在一个 extension 中
// 便于代码维护
// 注意： extension 中不能定义属性
// MARK: - 设置界面
extension WBMainViewController {
    
    
    /// 设置所有子控制器
    private func setupChildViewControllers() {
        let array = [
            ["clsName": "WBHomeViewController", "title": "首页", "imageName": ""],
            ["clsName": "WBMessageViewController", "title": "消息", "imageName": ""],
            ["clsName": "WBDiscoverViewController", "title": "发现", "imageName": ""],
            ["clsName": "WBProfileViewController", "title": "我的", "imageName": ""]
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
           arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
        
    }
    
    
    /// 使用字典创建一个子控制器
    ///
    /// - Parameter dict: 信息字典
    /// - Returns: 子控制器
    private func controller(dict: [String: String]) -> UIViewController {
        
        //1. 取字典内容
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type
            
            else {
                return UIViewController()
        }
        
        //创建视图控制器
        let vc = cls.init()
        vc.title = title;
        let nav = WBBaseNavigationController(rootViewController: vc)
        
        return nav
    }
}
