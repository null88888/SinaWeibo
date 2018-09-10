//
//  WBBaseViewController.swift
//  新浪微博
//
//  Created by ljw on 2018/9/7.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    //自定义导航栏
    //
    lazy var navigationBar = WBNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    //重新 title 的 didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
}

// MARK: -设置界面
extension WBBaseViewController {
    
     @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()

        //添加导航条
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
    }
}
