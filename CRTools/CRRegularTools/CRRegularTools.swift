//
//  CRRegularTools.swift
//
//
//  Created by 超人 on 2018/9/17.
//  Copyright © 2018年 超人. All rights reserved.
//

import Foundation

/**
 * 正则匹配
 */
enum CRRegularTools {
    
    case email(_: String) // 邮箱
    case phoneNum(_: String) // 手机号
    case phsNum(_: String) // 固定电话
    case username(_: String) // 用户名
    case password(_: String) // 密码
    case nickname(_: String) // 昵称
    case chinese(_: String) // 中文
    
    var isRight: Bool {
        
        var predicateStr: String = ""
        var currentStr: String = ""
        
        switch self {
        case .email(let str):
            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]_)\\.([a-z\\.]{2,6})$"
            currentStr = str
        case .phoneNum(let str):
            predicateStr = "^( (13[0-9]) | (15[^4,\\D]) | (17[0,0-9]) | (18[0,0-9]) ) \\ d{8}$"
            currentStr = str
        case .phsNum(let str):
            predicateStr = ""
            currentStr = str
        case .username(let str):
            predicateStr = "^[A-Za-z0-9]{6,20}+$"
            currentStr = str
        case .password(let str):
            predicateStr = "^[A-Za-z0-9]{6,20}+$"
            currentStr = str
        case .nickname(let str):
            predicateStr = ""
            currentStr = str
        case .chinese(let str):
            predicateStr = "^[\\u4e00-\\u9fa5]{0,}$"
            currentStr = str
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", predicateStr)
        return predicate.evaluate(with: currentStr)
    }
    
}
