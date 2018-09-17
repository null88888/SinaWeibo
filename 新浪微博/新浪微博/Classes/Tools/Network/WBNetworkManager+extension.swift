//
//  WBNetworkManager+extension.swift
//  新浪微博
//
//  Created by ljw on 2018/9/17.
//  Copyright © 2018年 ljw. All rights reserved.
//

import Foundation

// MARK: - 封装新浪微博的网络请求方法
extension WBNetworkManager {
    
    func statusList(completion: @escaping (_ list: [[String: Any]]?, _ isSuccess: Bool)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token": "2.00qBOg6GQeJrgD05be1950c3ZE9w_D"]
        request(URLString: urlString, parameters: params) { (json, isSuccess) in
            
            //从json中获取statuses字典数组
            //如果as？ 失败， result == nil
            let result = (json as AnyObject)["statuses"] as? [[String: Any]]
            completion(result,isSuccess)
        }
    }
}
