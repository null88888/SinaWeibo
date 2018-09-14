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
        
        //用网络工具 加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token": "2.00qBOg6GQeJrgD05be1950c3ZE9w_D"]
        WBNetworkManager.shared.request(URLString: urlString, parameters: params) { (json, isSuccess) in
            
            print(json)
        }
        
        
        print("开始加载数据")
        //模拟延迟
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            for i in 0..<15 {
                if self.isPullup {
                    self.statusList.append("上拉 \(i.description)")
                }else {
                    self.statusList.insert(i.description, at: 0)
                }
            }
            print("加载数据结束")
            self.refreshControl?.endRefreshing()
            self.tableView?.reloadData()
            //重置上拉刷新标识
            self.isPullup = false
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
    
    override func setupTableView() {
       super.setupTableView()

        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
