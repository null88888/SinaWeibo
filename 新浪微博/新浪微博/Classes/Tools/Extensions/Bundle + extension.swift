//
//  Bundle + extension.swift
//  反射机制
//
//  Created by ljw on 2018/9/5.
//  Copyright © 2018年 ljw. All rights reserved.
//

import Foundation

extension Bundle {
    
//    func nameSpace () -> String{
////        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
//        return infoDictionary?["CFBundleName"] as? String ?? ""
//
//    }
    
    //计算型属性类似于函数，有返回值
    var nameSpace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
