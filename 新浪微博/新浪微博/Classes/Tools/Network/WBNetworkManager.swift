//
//  WBNetworkManager.swift
//  新浪微博
//
//  Created by ljw on 2018/9/14.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit
import AFNetworking

/// 网络请求管理类
class WBNetworkManager: AFHTTPSessionManager {

    //静态 / 常量 / 闭包
    static let shared = WBNetworkManager()
}
