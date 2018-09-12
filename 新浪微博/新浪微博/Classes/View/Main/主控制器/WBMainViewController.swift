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
    
    /**
     portrait  :竖屏 （肖像）
     landscape :横屏 （风景画）
     
     - 使用代码控制设备的方向， 好处：可以再需要横屏的时候单独设置
     - 在Main中设置的原因： 设置支持的方向之后，当前的控制器和子控制器都会遵守这个方向
     - 如果是播放视频，通常是通过model展现的
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // 撰写微博点击事件
    // FIXME: 没有实现
    @objc private func composeStatus() {
        print("撰写微博")
        
        //测试方向旋转
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.cz_random()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
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
       
        //在现在的很多应用程序中， 界面的创建都依赖网络的json
        
        //1.路径 / 2.加载NSData /3.反序列化转成数组
        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
           let data = NSData(contentsOfFile: path),
        let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String: Any]]
            else {
               return
        }
        
        //遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        for dict in array! {
           arrayM.append(controller(dict: dict))
        }
        
        //设置 tabBar 的子控制器
        viewControllers = arrayM
    }
    
    
    /// 使用字典创建一个子控制器
    /// 反射机制 NSClassFromString
    /// - Parameter dict: 信息字典
    /// - Returns: 子控制器
    private func controller(dict: [String: Any]) -> UIViewController {
        
        //1. 取字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? WBBaseViewController.Type,
        let visitorInfo = dict["visitorInfo"] as? [String :String]
            
            else {
                return UIViewController()
        }
        
        //创建视图控制器
        let vc = cls.init()
        vc.title = title;
        //访客视图信息字典赋值
        vc.visitorInfoDictionary = visitorInfo
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
