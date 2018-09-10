//
//  WBBaseViewController.swift
//  新浪微博
//
//  Created by ljw on 2018/9/7.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit
//Swift中使用协议类似于多继承
//class WBBaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
class WBBaseViewController: UIViewController {

    var tableView: UITableView?
    
    //自定义导航栏
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

        setupNavigationBar()
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.delegate = self;
        tableView?.dataSource = self;
    }
    
    func setupNavigationBar() {
        //添加导航条
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension WBBaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //基类只是准备方法，子类负责具体的实现
    //子类的数据源方法不需要super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
