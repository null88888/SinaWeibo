//
//  WBHomeViewController.swift
//  新浪微博
//
//  Created by ljw on 2018/9/7.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {
    
    //微博数据数组
    private lazy var statusList = [String]()
    
    //加载数据
    override func loadData() {
        
        for i in 0..<15 {
            statusList.insert(i.description, at: 0)
        }
    }

    //显示好友
    @objc private func showFriends() {
        print(#function)
        let vc = WBDemoViewController()
        //隐藏tabBar
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: 表格视图代理方法
extension WBHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        cell?.textLabel?.text = statusList[indexPath.row]
        
        return cell!
    }
}

// MARK: 设置界面
extension WBHomeViewController {
    
    override func setupUI() {
        super.setupUI()

        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
