//
//  CRStaticTableViewItemModel.swift
//  StoneBaseDemo
//
//  Created by 超人 on 2018/9/26.
//  Copyright © 2018年 超人. All rights reserved.
//

import UIKit

enum CRStaticTableViewCellType {
    case noneType // 这里不可写成none，会跟系统的none冲突
    case indicatorType
    case switchType 
}

class CRStaticTableViewItemModel: NSObject {
    
    var title: String?
    var img: UIImage?
    var detailText: String?
    var detailmg: UIImage?
    var accessoryType: CRStaticTableViewCellType?
    
}

class CRStaticTableViewSectionModel: NSObject {
    
    var sectionHeaderName: String?
    var sectionHeaderHeight: CGFloat?
    var itemArray: [CRStaticTableViewItemModel]?
    var sectionHeaderBgColor: UIColor?
    
}


