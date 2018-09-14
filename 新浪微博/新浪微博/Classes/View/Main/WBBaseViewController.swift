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

    //用户登录标识
    var userLogon = true
    
    var visitorInfoDictionary: [String :String]?

    var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    //上拉刷新标识
    var isPullup = false
    //自定义导航栏
    lazy var navigationBar = WBNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
    
    //重新 title 的 didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    //由子类实现
    @objc func loadData() {
        //如果子类不实现该方法，结束刷新，不然刷新菊花一直存在
        refreshControl?.endRefreshing()
    }
}

// MARK: -访客视图监听方法
extension WBBaseViewController {
    
    @objc private func login() {
        print("登录")
    }
    
    @objc private func register() {
        print("注册")
    }
}

// MARK: -设置界面
extension WBBaseViewController {
    
     @objc private func setupUI() {
        view.backgroundColor = UIColor.white

        //取消自动缩进   默认缩进20
       // automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        userLogon ? setupTableView() : setupVisitorView()

    }
    
    @objc func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height - 20, left: 0, bottom: 0, right: 0)
        
        //添加刷新控件
        refreshControl = UIRefreshControl()
        tableView?.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    func setupVisitorView() {
        
        let visitorView = WBVisitorView(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navigationBar)
        visitorView.visitorInfo = visitorInfoDictionary
        
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
    }
    
    
    func setupNavigationBar() {
        //添加导航条
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
        
        // 1> 设置整个背景的渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        // 2> 设置nabBar 的字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        // 3> 设置系统按钮的文字渲染颜色
        navigationBar.tintColor = UIColor.orange
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
    
    //在显示最后一行时，加上上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !isPullup {
            print("上拉刷新")
            isPullup = true
            loadData()
        }
    }
    
}
