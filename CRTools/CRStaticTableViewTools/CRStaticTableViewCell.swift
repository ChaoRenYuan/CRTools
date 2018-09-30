//
//  CRStaticTableViewCell.swift
//  StoneBaseDemo
//
//  Created by 超人 on 2018/9/26.
//  Copyright © 2018年 超人. All rights reserved.
//

import UIKit

/**
 * 具有快速开发特性的静态TableViewCell
 * 这里命名以cr_开头，避免与自己项目的常量命名冲突
 */
class CRStaticTableViewCell: UITableViewCell {
    
    /**********************Variable**********************/
    private let cr_kScreenWidth = UIScreen.main.bounds.size.width
    private let cr_kScreenHeight = UIScreen.main.bounds.size.height
    fileprivate var item = CRStaticTableViewItemModel()
    /// 字体颜色
    var cr_commonTextColor = UIColor.black
    /// 字体大小
    var cr_commonTextFontOfSize: CGFloat = 15.0
    /// 默认靠左边和靠右边的间距
    private let cr_kRightSpace: CGFloat = 15.0
    /// detailText与detailImg的间距
    var cr_detailSpace: CGFloat = 5.0
    /// switch开关的点击事件
    var cr_switchBlock : ((Bool) -> ())?
    /// 分割图的高度
    var cr_segmentOfHeight: CGFloat = 1.0
    /// 箭头的Image，可自己自定义
    var cr_indicatorImg: UIImage = #imageLiteral(resourceName: "cr_icon_arrow.png")
    
    /**********************Lazy Loading**********************/
    public lazy var leftLbl: UILabel = {
        let tempView = UILabel.init()
        tempView.text = item.title ?? ""
        tempView.textColor = cr_commonTextColor
        tempView.font = UIFont.systemFont(ofSize: cr_commonTextFontOfSize)
        tempView.cr_size = cr_getTextSize(item.title ?? "", fontOfSize: cr_commonTextFontOfSize)
        tempView.cr_centerY = contentView.cr_centerY
        if self.item.img != nil {
            tempView.cr_x = self.imgV.cr_x + cr_kRightSpace
        } else {
            tempView.cr_x = cr_kRightSpace
        }
        
        return tempView
    }()
    public lazy var detailLbl: UILabel = {
        let tempView = UILabel.init()
        tempView.text = item.detailText ?? ""
        tempView.textColor = cr_commonTextColor
        tempView.font = UIFont.systemFont(ofSize: cr_commonTextFontOfSize)
        tempView.cr_size = cr_getTextSize(item.detailText ?? "", fontOfSize: cr_commonTextFontOfSize)
        tempView.cr_centerY = contentView.cr_centerY
        
        guard let type = item.accessoryType else {return tempView}
        switch type {
        case .indicatorType:
            tempView.cr_x = self.indicatorImgV.cr_x - tempView.cr_width - cr_kRightSpace
        case .switchType:
            tempView.cr_x = self.switchC.cr_x - tempView.cr_width - cr_kRightSpace
        case .noneType:
            tempView.cr_x = cr_kScreenWidth - cr_kRightSpace - tempView.cr_width
        }
        
        return tempView
    }()
    /// 箭头
    public lazy var indicatorImgV: UIImageView = {
        let tempView = UIImageView.init(image: cr_indicatorImg)
        tempView.cr_centerY = contentView.cr_centerY
        tempView.cr_x = cr_kScreenWidth - tempView.cr_width - cr_kRightSpace
        return tempView
    }()
    /// 主要的imgV
   public lazy var imgV: UIImageView = {
        let tempView = UIImageView.init(image: item.img)
        tempView.cr_centerY = contentView.cr_centerY
        tempView.cr_x = cr_kRightSpace
        return tempView
    }()
    /// 细节上的imgV
    public lazy var detailImgV: UIImageView = {
        let tempView = UIImageView.init(image: item.detailmg)
        tempView.cr_centerY = contentView.cr_centerY
        tempView.cr_x = self.detailLbl.cr_x - tempView.cr_width - cr_detailSpace
        return tempView
    }()
    /// 底部分割图
    public lazy var segmentView: UIView = {
        let tempView = cr_segmentView() // 默认白烟色
        tempView.cr_bottom = contentView.cr_bottom
        tempView.cr_width = contentView.cr_width
        tempView.cr_height = cr_segmentOfHeight
        tempView.cr_x = cr_kRightSpace
        return tempView
    }()
    /// switch开关
    public lazy var switchC: UISwitch = {
        let tempView = UISwitch.init()
        tempView.cr_centerY = contentView.cr_centerY
        tempView.cr_x = cr_kScreenWidth - tempView.cr_width - cr_kRightSpace
        tempView.addTarget(self, action: #selector(swiftTouch), for: UIControlEvents.valueChanged)
        return tempView
    }()
    /// switch开关的点击事件
    @objc private func swiftTouch(sender: UISwitch) {
        guard let block = cr_switchBlock else {return}
        block(sender.isOn)
    }

    
    /// 配置数据源
    func configureCellDataSource(item: CRStaticTableViewItemModel) {
        self.item = item
        createUI()
    }
   
    // MARK: - 创造UI
    private func createUI() {
    
        //如果有图片
        if (item.img != nil) {
            contentView.addSubview(imgV)
        }
        //标题
        if (item.title != nil) {
            contentView.addSubview(leftLbl)
        }
        
        //accessoryType
        if (item.accessoryType != nil) {
            cr_setupAccessoryType()
        }
        //detailText
        if (item.detailText != nil) {
            contentView.addSubview(detailLbl)
        }
        //detailmg
        if (item.detailmg != nil) {
            contentView.addSubview(detailImgV)
        }
        // 底部分割图
        contentView.addSubview(segmentView)

    }
    
    // MARK: - 获取字符串的CGSize
    private func cr_getTextSize(_ str: String, fontOfSize: CGFloat) -> CGSize {
        return str.boundingRect(with: CGSize.zero, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontOfSize)], context: nil).size
    }
    
    /// 分割图
    func cr_segmentView(color: UIColor = .cr_hexColor("#F5F5F5")) -> UIView {
        let tempView = UIView()
        tempView.backgroundColor = color
        return tempView
    }
    
    // MARK: - 设置AccessoryType
    private func cr_setupAccessoryType() {
        guard let type = item.accessoryType else {return}
        switch type {
        case .noneType:
            break
        case .indicatorType:
            contentView.addSubview(indicatorImgV)
        case .switchType:
            contentView.addSubview(switchC)
        }
    }

}
