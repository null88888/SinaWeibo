//
//  WBDemoViewController.swift
//  新浪微博
//
//  Created by ljw on 2018/9/7.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "第 \(navigationController?.childViewControllers.count ?? 0)个"
    }
    
    @objc private func showNext() {
        
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WBDemoViewController {
    
    override func setupUI() {
        super.setupUI()
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
    }
}
