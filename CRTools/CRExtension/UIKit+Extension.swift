//
//  UIKit+Extension.swift
//  StoneBaseDemo
//
//  Created by 超人 on 2018/9/17.
//  Copyright © 2018年 超人. All rights reserved.
//

import UIKit

// MARK: - UIView
extension UIView {
    
    /// x
    var cr_x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var cr_y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var cr_height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var cr_width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var cr_size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    var cr_centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    var cr_centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
    
    /// bottom
    var cr_bottom: CGFloat {
        get { return cr_y + cr_height }
        set(newVal) {
            cr_y = newVal - cr_height
        }
    }
    
    /// 分割图
    static func cr_segmentView(color: UIColor = .cr_hexColor("#F5F5F5")) -> UIView {
        let tempView = UIView()
        tempView.backgroundColor = color
        return tempView
    }
}

// MARK: - UITableView
extension UITableView {
    
    /// 注册 cell 的方法
    public func cr_registerCellClass(_ cellClass: Swift.AnyClass) -> () {
        self.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
    }
    
    /// 从缓存池取出已经存在的 cell
    public func cr_dequeueReusableCell<T:UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: NSStringFromClass(cellType), for: indexPath) as! T
    }
    
    /// 注册 headerFooterView 的方法
    public func cr_registerHeaderFooterViewClass(_ headerFooterViewClass: Swift.AnyClass) -> () {
        self.register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: NSStringFromClass(headerFooterViewClass))
    }
    
    /// 从缓存池池出队已经存在的 headerFooterView
    public func cr_dequeueReusableHeaderFooterView<T:UITableViewHeaderFooterView>(headerFooterViewType: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(headerFooterViewType)) as! T
    }
    
}

// MARK: - UIImage
extension UIImage {
    
    /// 设置originalImg
    static func setOriginalImg(_ imgName: String) -> UIImage {
        guard let img = UIImage(named: imgName) else {return UIImage()}
        return img.withRenderingMode(.alwaysOriginal)
    }
    
    /// 传一个UIColor，返回UIImage
    static func imageWithColor(_ color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    
}

// MARK: - UILabel
extension UILabel {
    // 遍历构造器必须以 convenience 开头, 并且调用自身init构造器方法(注意: 不需要return)
    convenience init(text: String?, textColor: UIColor?, font: CGFloat?, bgColor: UIColor?, align: NSTextAlignment = .left) {
        self.init()
        //设置标题
        if let title = text {
            self.text = title
        }
        //设置标题颜色
        if let color = textColor {
            self.textColor = color
        }
        //设置字体大小
        if let fontResult = font {
            self.font = UIFont.systemFont(ofSize: fontResult)
        }
        //设置背景颜色
        if let bgColorResult = bgColor {
            self.backgroundColor = bgColorResult
        }
        
        self.textAlignment = align
    }
    
}

// MARK: - UITextField
extension UITextField {
    // 遍历构造器必须以 convenience 开头, 并且调用自身init构造器方法(注意: 不需要return)
    convenience init(text: String?, textColor: UIColor?, font: CGFloat?, bgColor: UIColor?) {
        self.init()
        //设置标题
        if let title = text {
            self.text = title
        }
        //设置标题颜色
        if let color = textColor {
            self.textColor = color
        }
        //设置字体大小
        if let fontResult = font {
            self.font = UIFont.systemFont(ofSize: fontResult)
        }
        //设置背景颜色
        if let bgColorResult = bgColor {
            self.backgroundColor = bgColorResult
        }
    }
    
}

// MARK: - UITextView
extension UITextView {
    // 遍历构造器必须以 convenience 开头, 并且调用自身init构造器方法(注意: 不需要return)
    convenience init(text: String?, textColor: UIColor?, font: CGFloat?, bgColor: UIColor?) {
        self.init()
        //设置标题
        if let title = text {
            self.text = title
        }
        //设置标题颜色
        if let color = textColor {
            self.textColor = color
        }
        //设置字体大小
        if let fontResult = font {
            self.font = UIFont.systemFont(ofSize: fontResult)
        }
        //设置背景颜色
        if let bgColorResult = bgColor {
            self.backgroundColor = bgColorResult
        }
    }
    
}

// MARK: UIColor
extension UIColor {
    /// UIColor 16进制编码转换RGB
    static func cr_hexColor(_ cr_hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexStr = cr_hex.uppercased()
        if (hexStr.hasPrefix("#")) {
            hexStr = (hexStr as NSString).substring(from: 1)
        }
        let scanner = Scanner(string: hexStr)
        scanner.scanLocation = 0
        var RGBValue: UInt64 = 0
        scanner.scanHexInt64(&RGBValue)
        let r = (RGBValue & 0xff0000) >> 16
        let g = (RGBValue & 0xff00) >> 8
        let b = RGBValue & 0xff
        return UIColor(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha)
    }
    
}

// MARK: - 设置UIButton
extension UIButton {
    
    /// 遍历构造器必须以 convenience 开头, 并且调用自身init构造器方法(注意: 不需要return)
    convenience init(title: String = "", titleColor: UIColor?, titleFont: CGFloat?, bgColor: UIColor?, target: Any? = nil, btnSelector: Selector? = nil) {
        self.init()
        
        self.setTitle(title, for: .normal)
        
        if let titleForColor = titleColor {
            self.setTitleColor(titleForColor, for: .normal)
        }
        if let font = titleFont {
            self.titleLabel?.font = UIFont.systemFont(ofSize: font)
        }
        if let btnBgColor = bgColor {
            self.backgroundColor = btnBgColor
        }
        if let btnTarget = target, let selector = btnSelector {
            self.addTarget(btnTarget, action: selector, for: .touchUpInside)
        }
    }
    
    /// 以下方法是拓展按钮中的图片和文字的位置关系
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    private func positionLabelRespectToImage(title: String, position: UIViewContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}

// MARK: - UIDevice
extension UIDevice {
    /// 是否是ipad
    class var isIpad: Bool {
        return UIDevice.current.model.contains("iPad")
    }
    /// 设备型号
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":   return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":  return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "i386", "x86_64":      return "Simulator"
        default:  return identifier
        }
    }
}
