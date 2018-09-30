//
//  Foundation+Extension.swift
//  StoneBaseDemo
//
//  Created by 超人 on 2018/9/17.
//  Copyright © 2018年 超人. All rights reserved.
//

import UIKit

// MARK: - Double
extension Double {
    static let SCREEN_W_4  = 320.0;
    static let SCREEN_H_4 = 480.0;
    static let SCREEN_W_5S = 320.0;
    static let SCREEN_H_5S = 568.0;
    static let SCREEN_W_6  = 375.0;
    static let SCREEN_H_6  = 667.0;
    static let SCREEN_W_6P = 414.0;
    static let SCREEN_H_6P = 736.0;
    static let SCREEN_W_X  = 375.0;//!<iPhoneX屏幕宽度
    static let SCREEN_H_X  = 812.0;//!<iPhoneX屏幕高度
    
    var fit: CGFloat {
        let cr_tempH = UIScreen.main.bounds.height
        let cr_tempW = UIScreen.main.bounds.width
        if Double(cr_tempH) == Double.SCREEN_H_4 {
            return  (cr_tempH / CGFloat(Double.SCREEN_H_6))
        }
        return  (cr_tempW / CGFloat(Double.SCREEN_W_6))
    }
}

// MARK: - String
extension String {
    /// 过滤HTML标签的方法
    static func regularFilter(_ str: String, pattern: String, with: String, options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        
        var html = regex.stringByReplacingMatches(in: str, options: [], range: NSMakeRange(0, str.count), withTemplate: with)
        html = html.replacingOccurrences(of: "&nbsp;", with: "")
        html = html.replacingOccurrences(of: "&#34;", with: "\"")
        html = html.replacingOccurrences(of: "\n", with: "")
        html = html.replacingOccurrences(of: "\r", with: "")
        html = html.replacingOccurrences(of: "\t", with: "")
        return html
    }
    /// 获取指定字符串的CGSize
    static func getTextSize(_ str: String, fontOfSize: CGFloat) -> CGSize {
        return str.boundingRect(with: CGSize.zero, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontOfSize)], context: nil).size
    }

    
}

