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
        setupComposeButton()
        
    }
    
    // 撰写微博点击事件
    // FIXME: 没有实现
    @objc private func composeStatus() {
        print("撰写微博")
    }
    
    // MARK: - 私有控件
    private lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
}

// extension 类似于OC中的 分类， 在Swift中还可以用来分割代码
// 可以把相近功能的函数， 放在一个 extension 中
// 便于代码维护
// 注意： extension 中不能定义属性
// MARK: - 设置界面
extension WBMainViewController {
    
    //设置编撰按钮
    private func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        //不同类型不能进行计算（Int / CGFloat）
        //计算出每个tabBarItem的宽度，在第三个位置插入，需要 -1 覆盖容错点，否则有几率点击到背后的按钮
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count) - 1
        composeButton.frame = tabBar.bounds.insetBy(dx: width * 2, dy: 0)
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    /// 设置所有子控制器
    private func setupChildViewControllers() {
        let array = [
            ["clsName": "WBHomeViewController", "title": "首页", "imageName": "tabbar_home"],
            ["clsName": "WBMessageViewController", "title": "消息", "imageName": "tabbar_message_center"],
            //中间添加一个空的UIViewController，用于添加composeButton
            ["clsName": "UIViewController", "title": "", "imageName": ""],
            ["clsName": "WBDiscoverViewController", "title": "发现", "imageName": "tabbar_discover"],
            ["clsName": "WBProfileViewController", "title": "我的", "imageName": "tabbar_profile"]
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
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //设置字体大小  Swift4.0 将 NSForegroundColorAttribute 系列替换为NSAttributedStringKey.foregroundColor 等方式
       vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor:UIColor.orange], for: .highlighted)
       vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)],
            for: .normal)
        
        // 实例化导航控制器的时候， 会调用 push 方法将rootVC 压栈
        let nav = WBBaseNavigationController(rootViewController: vc)
        
        return nav
    }
}
