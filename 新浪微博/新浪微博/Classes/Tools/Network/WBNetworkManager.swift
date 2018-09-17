//
//  WBNetworkManager.swift
//  新浪微博
//
//  Created by ljw on 2018/9/14.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit
import AFNetworking

enum WBHTTPMethod {
    case GET
    case POST
}



/// 网络请求管理类
class WBNetworkManager: AFHTTPSessionManager {

    //静态 / 常量 / 闭包
    static let shared = WBNetworkManager()
    
    /// 使用一个函数封装GET 和 POST
    ///
    /// - Parameters:
    ///   - method:        GET/ POST
    ///   - URLString:     路径
    ///   - parameters:    参数字典
    ///   - completion:    完成回调（json字典/数组， 是否成功）
    func request(method: WBHTTPMethod = .GET, URLString: String, parameters: [String: Any?], completion:@escaping (_ json: Any?, _ isSuccess: Bool)->()) {
        
//        let success = { (task: URLSessionDataTask, json: Any?)->() in
//            completion(json, true)
//
//        }
//
//        let failure = { (task: URLSessionDataTask, error: NSError)->() in
//            completion(nil, false)
//
//        }
        
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: { (task, json) in
                
                completion(json,true)
                
            }) { (task, error) in
               print("网络请求错误")
                completion(nil,false)
            }
       
        } else {
            post(URLString, parameters: parameters, progress: nil, success: { (task, json) in
                
                completion(json,true)
                
            }) { (task, error) in
                print("网络请求错误")
                completion(nil,false)
                
            }
        }
        
    }
}
