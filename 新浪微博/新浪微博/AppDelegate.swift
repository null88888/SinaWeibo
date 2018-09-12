//
//  AppDelegate.swift
//  新浪微博
//
//  Created by ljw on 2018/9/5.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        sleep(2)
        window = UIWindow()
        window?.backgroundColor = UIColor.white;
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()

        loadAppInfo()
        
        return true
    }
}

extension AppDelegate {
    
    private func loadAppInfo() {
        
        //1.模拟异步
        DispatchQueue.global().async {
            
            // - url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            // - data
            let data = NSData(contentsOf: url!)
            // - 写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序加载完毕\(jsonPath)")
        }
    }
}

