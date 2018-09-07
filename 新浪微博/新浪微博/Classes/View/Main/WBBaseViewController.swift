//
//  WBBaseViewController.swift
//  新浪微博
//
//  Created by ljw on 2018/9/7.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

// MARK: -设置界面
extension WBBaseViewController {
    
     @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()

    }
}
